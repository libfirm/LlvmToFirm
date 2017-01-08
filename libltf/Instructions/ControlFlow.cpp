#include "../Builders/NodeBuilder.hpp"

#include <vector>
#include <sstream>
#include <cassert>
#include <climits>
#include <utility>
#include <iterator>
#include <boost/foreach.hpp>
#include <llvm/Support/Casting.h>
#include <llvm/Function.h>
#include <llvm/Intrinsics.h>
#include <llvm/Instructions.h>
#include <libfirm/firm.h>
#include "../Context.hpp"
#include "../Builders/TypeBuilder.hpp"
#include "../Builders/GraphBuilder.hpp"
#include "../Builders/FrameBuilder.hpp"
#include "../Builders/BlockBuilder.hpp"
#include "../RAII/BlockScope.hpp"
#include "../RAII/AllocaScope.hpp"
#include "../Util/Logging.hpp"
#include "../Util/Casting.hpp"
#include "../Util/TypeInfo.hpp"
#include "../Exceptions/NotSupportedException.hpp"
#include "../Exceptions/NotImplementedException.hpp"
#include "../Typedef/Map.hpp"
using namespace boost;
using llvm::isa;
using llvm::cast;

namespace ltf
{
    /* ====================================================================== */
    /* =                                Call                                = */
    /* ====================================================================== */
    
    // ([atom] | [tuple])* -> [atom] | [tuple]
    ir_node* NodeBuilder::buildCall(const llvm::CallInst* inst)
    {
        AllocaScope allocaScope;
        
        // TODO: calling conventions, attributes
        const llvm::FunctionType* funcType    = 0;
        ir_node*                  funcPtrNode = 0;

        // Pointer call or direct function call?
        if (inst->getCalledFunction() == 0)
        {
            // Considering the casts in CallInst::init(), the pointer value
            // should always point to a function type. Just what we need.
            const llvm::Value* ptrValue = inst->getCalledValue();
            
            // Get the pointer and function type.
            funcPtrNode = retrieve(ptrValue);
            funcType    = cast<llvm::FunctionType>(
                cast<llvm::PointerType>(ptrValue->getType())->getElementType()
            );
        }
        else
        {
            unsigned int id = inst->getCalledFunction()->getIntrinsicID();
            switch (id)
            {
            // No intrinsic, handle as usual.
            case llvm::Intrinsic::not_intrinsic: break;
            
            // The va_arg intrinsic family isn't lowered, because we can't
            // obtain a pointer to an argument directly in LLVM.
            case llvm::Intrinsic::vastart: return buildVAStart(inst);
            case llvm::Intrinsic::vacopy:  return buildVACopy(inst);
            case llvm::Intrinsic::vaend:   return buildVAEnd(inst);
                
            default:
                std::ostringstream messageStr;
                messageStr << "Can't translate \"" << llvm::Intrinsic::getName(
                    static_cast<llvm::Intrinsic::ID>(id)) << "\" intrinsic call";
                
                throw NotSupportedException(messageStr.str());
            }
            
            ir_entity* entity = context.retrieveEntity(inst->getCalledFunction());
            assert((entity != 0) && "Function entity not found");

            // Create a symbolic constant for the function entity.
            symconst_symbol functionSymbol;
            functionSymbol.entity_p = entity;
            
            funcPtrNode = new_SymConst(mode_P, functionSymbol, symconst_addr_ent);
            funcType    = inst->getCalledFunction()->getFunctionType();
        }
        
        assert((funcType    != 0) && "Couldn't retrieve a function type");
        assert((funcPtrNode != 0) && "Couldn't retrieve a function pointer");
        
        // Build up metadata, to retrieve the function type.
        shared_ptr<FunctionTypeMetakey> metadata(new FunctionTypeMetakey());
        metadata->addAttributes(inst->getAttributes());
        metadata->setCallingConvention(inst->getCallingConv());
        
        if (funcType->isVarArg())
        {
            log::debug << "Constructing variadic function instance" << log::end;
            
            // It seems, that variadic function calls need to construct a method
            // type with the specific arguments of the call.
            int baseParamCount = funcType->getNumParams();
            int callParamCount = inst->getNumOperands() - baseParamCount - 1;
            assert(callParamCount >= 0);

            // Append call parameters.
            for (int i = 0; i < callParamCount; i++)
            {
                metadata->addVariadicParam(inst->getOperand(
                    1 + baseParamCount + i)->getType());
            }   
        }
        
        // Retrieve the function type.
        ir_type* fFuncType = context.getTypeBuilder()->retrieveFunction(
            funcType, metadata
        );

        assert((fFuncType != 0) && "Missing function type");
        
        const llvm::Type* retType    = funcType->getReturnType();
        unsigned int      paramCount = get_method_n_params(fFuncType);
        ir_node*          paramNodes[paramCount];
        
        for (unsigned int i = 0; i < paramCount; i++)
        {
            llvm::Value*      paramValue = inst->getOperand(1 + i);
            const llvm::Type* paramType  = paramValue->getType();
            ir_node*          paramNode  = retrieve(paramValue);
            
            if (metadata->isByValIndex(i))
            {
                // If this is a pointer to some aggregate, everything will be
                // fine. Firm will recognize from the parameter type, that it
                // has to pass the parameter by value.
                // However if the type pointed to is an atom, firm complains
                // about a mode mismatch.
                
                assert(ti::isPtr(paramType) && "Non-pointer passed byval");
                const llvm::Type* baseType = cast<llvm::PointerType>(
                    paramType)->getElementType();
                
                if (ti::isAtom(baseType))
                {
                    log::debug << "Atom explicitly passed by value" << log::end;
                    
                    // Load the value from memory.
                    ir_mode* loadMode = ti::getBaseMode(baseType);
                    ir_node* loadNode = new_Load(
                        get_store(), paramNode, loadMode, cons_none
                    );
                    
                    set_store(new_Proj(loadNode, mode_M, pn_Load_M));
                    
                    // Update param and type so they are properly handled.
                    paramNode = new_Proj(loadNode, loadMode, pn_Load_res);
                    paramType = baseType;
                }
            }
            
            if (ti::isTuple(paramType))
            {
                log::debug << "Tuple parameter value" << log::end;
                
                // Allocate some memory on the stack and store the aggregate
                // there, to pass a pointer to the function.
                ir_type* fParamType = context.retrieveType(paramType);
                ir_node* ptrNode    = allocaScope.allocate(fParamType);
                buildTupleStore(paramNode, ptrNode, paramType);
                
                paramNodes[i] = ptrNode;
            }
            else if (ti::isAtom(paramType))
            {                
                paramNodes[i] = ac::atomToBase(paramType, paramNode, false);
            }
            else
            {
                throw NotSupportedException("Non-atomic and non-tuple param");
            }
        }
        
        // Create the call node.
        ir_node* callNode = new_Call(
            get_store(), funcPtrNode, paramCount, paramNodes, fFuncType
        );
        
        set_store(new_Proj(callNode, mode_M, pn_Call_M));
        
        // Retrieve the return value node.
        ir_node* tupleNode = new_Proj(callNode, mode_T, pn_Call_T_result);
        ir_node* retNode   = 0;
        
        if (retType->getTypeID() == llvm::Type::VoidTyID)
        {
            retNode = 0; // Void returns no value.
        }
        else if (ti::isTuple(retType))
        {
            log::debug << "Tuple return value" << log::end;
            
            // Get an anonymous entity for the return value. Unfortunately,
            // this will make each aggregate call in the function take up some
            // space for the return value, that isn't freed.
            // However using alloca and free won't work, although there are no
            // loads after the free. My guess is, that firm inserts the load on
            // access, so that free can only be used, if no access whatsoever
            // occurs after the free. This would need a more complex analysis,
            // that is being skipped for now.
            
            ir_entity* entity     = frameBuilder->retrieveAnonymousEntity(retType);
            ir_node*   srcPtrNode = new_Proj(tupleNode, mode_P, 0);
            ir_node*   dstPtrNode = new_simpleSel(
                new_NoMem(), get_irg_frame(graph), entity
            );
            
            // Copy the returned data over to the new entity.
            ir_type* fRetType = context.retrieveType(retType);
            ir_node* copyNode = new_CopyB(
                get_store(), dstPtrNode, srcPtrNode, fRetType
            );
            
            set_store(new_Proj(copyNode, mode_M, pn_CopyB_M));
            
            // Now deserialize the aggregate from the new entity.
            retNode = buildTupleLoad(dstPtrNode, retType);
        }
        else if (ti::isAtom(retType))
        {
            // Proj the result from the returned tuple.
            ir_mode* retMode = ti::getBaseMode(retType);
            assert((retMode != 0) && "Invalid return type");
            retNode = new_Proj(tupleNode, retMode, 0);
        }
        else
        {
            throw NotSupportedException("Non-atomic and non-tuple return");
        }

        return retNode;
    }
    
    /* ====================================================================== */
    /* =                               Return                               = */
    /* ====================================================================== */
    
    // [atom] | [tuple]
    ir_node* NodeBuilder::buildReturn(const llvm::ReturnInst* inst)
    {
        // Get and convert the return value.
        const llvm::Value* retValue = inst->getReturnValue();
        ir_node*           retNode  = 0;

        if (retValue != 0)
        {
            const llvm::Type* retType = retValue->getType();
                              retNode = retrieve(retValue);

            if (ti::isTuple(retType))
            {
                log::debug << "Tuple return value" << log::end;
                
                // Get the return entity.
                ir_entity* entity  = frameBuilder->retrieveReturnEntity(retType);
                ir_node*   ptrNode = new_simpleSel(
                    new_NoMem(), get_irg_frame(graph), entity
                );

                // Serialize the aggregate and return a pointer.
                buildTupleStore(retNode, ptrNode, retType);
                retNode = new_Return(get_store(), 1, &ptrNode);
            }
            else if (ti::isAtom(retType))
            {
                // Return the value.
                retNode = ac::atomToBase(retType, retNode, false);
                retNode = new_Return(get_store(), 1, &retNode);
            }
            else
            {
                throw NotSupportedException("Non-atomic and non-tuple return");
            }
        }
        else
        {
            retNode = new_Return(get_store(), 0, 0);
        }
        
        // Prepend the node to the return block.
        assert(retNode != 0);
        
        blockBuilder->registerJump(inst->getParent(), 0, retNode);
        set_cur_block(new_Bad());
        
        return 0;
    }
    
    /* ====================================================================== */
    /* =                               Branch                               = */
    /* ====================================================================== */
    
    // [bool]
    ir_node* NodeBuilder::buildBranch(const llvm::BranchInst* inst)
    {
        const llvm::BasicBlock* block = inst->getParent();
        
        // For conditional branches, construct a cond node.
        if (inst->isConditional())
        {
            assert((inst->getNumSuccessors() == 2) &&
                "Invalid number of branch target blocks");
            
            // Get the predicate value node.
            llvm::Value* predValue = inst->getCondition();
            ir_node*     predNode  = retrieve(predValue);
            predNode = ac::boolToB(predValue->getType(), predNode);
            
            // Create a condition node with projs for the branches.
            ir_node* condNode  = new_Cond(predNode);
            ir_node* trueProj  = new_Proj(condNode, mode_X, pn_Cond_true);
            ir_node* falseProj = new_Proj(condNode, mode_X, pn_Cond_false);
            
            // Wire the projs to the according blocks.
            llvm::BasicBlock* trueBlock  = inst->getSuccessor(0);
            llvm::BasicBlock* falseBlock = inst->getSuccessor(1);
            
            blockBuilder->registerJump(block, trueBlock,  trueProj);
            blockBuilder->registerJump(block, falseBlock, falseProj);
            
            return condNode;
        }

        assert((inst->getNumSuccessors() == 1) &&
            "Invalid number of branch target blocks");
        
        llvm::BasicBlock* targetBlock = inst->getSuccessor(0);
        ir_node*          jumpNode    = new_Jmp();
        
        // Tell the block builder about the jump.
        blockBuilder->registerJump(block, targetBlock, jumpNode);
        set_cur_block(new_Bad());
        
        return 0;
    }
    
    /* ====================================================================== */
    /* =                               Switch                               = */
    /* ====================================================================== */
    
    // [int-atom]
    ir_node* NodeBuilder::buildSwitch(const llvm::SwitchInst* inst)
    {
        // XXX: make the spare size configurable.
        const llvm::BasicBlock* block          = inst->getParent();
        const llvm::Value*      switchValue    = inst->getCondition();
        
        if (!ti::isIntAtom(switchValue->getType()))
        {
            throw NotSupportedException("Non-int-atomic switch");
        }
        
        // If the condition is bigger than an int, we can't construct a proj
        // for it and need a cascade. Also firm switch is limited to 32 bit.
        unsigned int maxWidth = sizeof(int) * 8;
        if (maxWidth > 32) maxWidth = 32;
        
        if (ti::getWidth(switchValue->getType()) > maxWidth)
        {
            log::debug << "If-cascade due to switch value > 32 bit" << log::end;
            return buildIfCascade(inst);
        }
        
        // If/else and empty switch cases.
        if (inst->getNumCases() <= 1)
        {
            log::debug << "Too small switch found" << log::end;
            return buildIfCascade(inst);
        }

        unsigned int minCase = UINT_MAX;
        unsigned int maxCase = 0;
        
        // There is at least one case other than default now. Determine the
        // minimal and maximal case values.
        for (unsigned int i = 1; i < inst->getNumCases(); i++)
        {
            unsigned int value = static_cast<unsigned int>(
                inst->getCaseValue(i)->getLimitedValue()
            );
            
            if (value < minCase) minCase = value;
            if (value > maxCase) maxCase = value;
        }
        
        // This happens in case -1 for example. Alas we don't have a free
        // case bigger than that left for the default proj.
        if (maxCase == UINT_MAX)
        {
            // This may be fixed, by shifting the condition range, but for now
            // just use a cascade. XXX: do this later?
            log::debug << "If-cascade due to case -1" << log::end;
            return buildIfCascade(inst);
        }

        // Get an unsigned int switch value.
        ir_node* switchNode = retrieve(switchValue);
        unsigned width      = ti::getWidth(switchValue->getType());
        switchNode = ac::ZExt(switchNode, width, mode_Iu);

        // This is a so-called fragmentary Cond. See irnode.h.
        ir_node* condNode = new_Cond(switchNode);
        
        for (unsigned int i = 1; i < inst->getNumCases(); i++)
        {
            unsigned int value = static_cast<unsigned int>(
                inst->getCaseValue(i)->getLimitedValue()
            );
            
            // Construct a proj for the case.
            ir_node*          caseProj  = new_Proj(condNode, mode_X, value);
            llvm::BasicBlock* caseBlock = inst->getSuccessor(i);
            blockBuilder->registerJump(block, caseBlock, caseProj);
        }
                
        // Construct the default case. MaxCase + 1 will not overflow!
        ir_node* caseProj = new_defaultProj(condNode, maxCase + 1);
        blockBuilder->registerJump(block, inst->getDefaultDest(), caseProj);
        
        set_cur_block(new_Bad());
        return 0;
    }
    
    /* ====================================================================== */
    /* =                            Unreachable                             = */
    /* ====================================================================== */
    
    ir_node* NodeBuilder::buildUnreachable(const llvm::UnreachableInst* inst)
    {
        // This is a terminator instruction and as such the last one in this
        // block. Because of that, the block will never be connected to the
        // end block and thus be unreachable.
        // That however will be detected by BlockBuilder::keepBlocksAlive(),
        // which will keep this block and the last known memory value in this
        // block alive, if we register the no-op terminator here.
        
        blockBuilder->registerJump(inst->getParent());
        return 0;
    }
    
    /* ====================================================================== */
    /* =                             Phi nodes                              = */
    /* ====================================================================== */
    
    // Constructing phi nodes is a two-step process. When a phi instruction is
    // first encountered, a phi node with the appropriate mode, but zero input
    // values is built and stored in the cache (the proxy). Once the whole
    // function graph is constructed, the phi nodes are visited again.
    // This time, each input is guaranteed to be available (possibly as phi
    // proxy, in case of a phi to phi dependance, but that shouldn't matter),
    // so the real phi node is constructed and exchanged with the proxy node
    // (in the firm graph and the cache), effectively putting the new phi node
    // into place.
    // This is actually the same thing, that set_value() and get_value() do,
    // but since we know exactly what phi nodes we need, it is easier to stay
    // clear of those methods (no variable allocation, worries about execution
    // order etc.)
    
    ir_node* NodeBuilder::buildPhiProxy(const llvm::PHINode* inst)
    {
        const llvm::BasicBlock* block   = inst->getParent();
        ir_mode*                resMode = ti::getBaseMode(inst->getType());
        assert((resMode != 0) && "Invalid result mode");
        
        // Prevent the block from being matured, when the other instructions
        // are constructed. There is still some work to be done here.
        blockBuilder->raiseReferenceCount(block);
        return new_Phi(0, 0, resMode);
    }
    
    // [atom] | [tuple]
    ir_node* NodeBuilder::buildPhi(const llvm::PHINode* phi)
    {
        assert(phi);
        
        // Create a list of block/value pairs.
        NodeMap blockValues;
        
        for (unsigned int i = 0; i < phi->getNumIncomingValues(); i++)
        {
            const llvm::BasicBlock* block  = phi->getIncomingBlock(i);
            ir_node*                fBlock = blockBuilder->retrieve(block);
            assert((fBlock != 0) && "Missing block");
            
            // Ensure that all inputs have the same mode.
            const llvm::Value* inputValue = phi->getIncomingValue(i);
            ir_node*           inputNode  = retrieve(inputValue);
            
            // Change scope, in case convert creates conv nodes.
            BlockScope scope(fBlock);
            
            if (ti::isAtom(phi->getType()))
            {
                // Turn all values to their base type. XXX: Could be optimized.
                inputNode = ac::atomToBase(phi->getType(), inputNode);
            }
            else if (!ti::isTuple(phi->getType()))
            {
                throw NotSupportedException("Non-atomic and non-tuple switch");
            }
            
            // Note that an incoming block may appear multiple times. In that
            // case however the verifier enforces that every appearance has the
            // same value, so we only need to store one value for each block.
            blockValues.insert(NodePair(fBlock, inputNode));
        }
        
        NodeVect srcNodes;
        int      inputCount = get_irn_arity(get_cur_block());
        ir_node* inputs[inputCount];
        
        ir_mode* resMode = ti::getBaseMode(phi->getType());
        assert((resMode != 0) && "Invalid result mode");
        
        for (int i = 0; i < inputCount; i++)
        {
            srcNodes.clear();
            
            // Find the appropriate predecessor block in firm.
            ir_node* jumpNode  = get_irn_n(get_cur_block(), i);
            ir_node* predBlock = get_nodes_block(jumpNode);
            
            // Sometimes firm will optimize predecessor blocks away. This may
            // happen for example, if a branch will never take one of the two
            // projs from it. Then the proj is automatically replaced by a bad
            // block, that may end up here and we can't handle it.
            // Because such a jump can never be taken, we can safely insert an
            // unknown value here. Control flow optimization should probably
            // remove the bad predecessor and update the phi anyway.
            if (get_irn_op(jumpNode) == op_Bad)
            {
                log::debug << "Bad block on phi node. "
                    "Using unknown value." << log::end;
                inputs[i] = new_Unknown(resMode);
                continue;
            }
            
            // Fetch all possible phi sources for this block and select the
            // (unambiguous) source that we have a value for.
            blockBuilder->fetchPhiSources(predBlock, std::back_inserter(srcNodes));
            ir_node* valueNode = 0;
            
            BOOST_FOREACH (ir_node* sourceNode, srcNodes)
            {
                // Try to find that block in the list of incoming values.
                NodeMapIt it = blockValues.find(sourceNode);
                if (it != blockValues.end())
                {
                    // Ensure, that we only have one value for the dependency.
                    assert((valueNode == 0) && "Ambiguous phi dependency");
                    valueNode = it->second;
                }
            }
            
            assert((valueNode != 0) && "Unresolved phi dependency");
            inputs[i] = valueNode;
        }
        
        log::debug << "Finishing phi construction" << log::end;
        
        // Construct the actual phi node and exchange it with the phi proxy
        // from the current cache and replace the cache entry.
        ir_node* phiNode   = new_Phi(inputCount, inputs, resMode);
        ir_node* proxyNode = retrieve(phi);
        assert((proxyNode != 0) && "Missing phi proxy");

        exchange(proxyNode, phiNode);
        cacheReplace(phi, phiNode);

        // The reference count of the block can be lowered again.
        blockBuilder->lowerReferenceCount(phi->getParent());
        return phiNode;
    }
}
