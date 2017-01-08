#include "NodeBuilder.hpp"

#include <cassert>
#include <sstream>
#include <llvm/Module.h>
#include <llvm/Support/Casting.h>
#include <llvm/Operator.h>
#include <llvm/Instruction.h>
#include <llvm/Instructions.h>
#include <libfirm/firm.h>
#include "../Util/Logging.hpp"
#include "../RAII/BlockScope.hpp"
#include "../Builders/TypeBuilder.hpp"
#include "../Builders/BlockBuilder.hpp"
#include "../Context.hpp"
#include "../Exceptions/NotImplementedException.hpp"
using namespace boost;
using llvm::isa;
using llvm::cast;

namespace ltf
{
    NodeBuilder::NodeBuilder(Context& context)
        : context(context), graph(get_const_code_irg()) { }
    
    NodeBuilder::NodeBuilder(
        Context& context,
        ir_graph* graph,
        BlockBuilderSPtr blockBuilder,
        FrameBuilderSPtr frameBuilder
    )
        : context(context), graph(graph),
          blockBuilder(blockBuilder),
          frameBuilder(frameBuilder)
    {
        assert(graph != 0);
        assert(blockBuilder.get() != 0);
        assert(frameBuilder.get() != 0);
    }

    /* ====================================================================== */
    /* =                         Build entry point                          = */
    /* ====================================================================== */
    
    ir_node* NodeBuilder::retrieve(const llvm::Value* value, bool& wasCached)
    {
        ir_node* valueNode = Base::retrieve(value, wasCached);
        assert(!(isa<llvm::Instruction>(value) && !wasCached) &&
            "Can't retrieve instructions on-demand");
        return valueNode;
    }

    // [TODO]        invoke, unwind, frem, va_arg
    // [UNSUPPORTED] extractelement, insertvalue
    ir_node* NodeBuilder::doBuild(const llvm::Value* value, bool& doCache)
    {
        // Ensure that the correct graph is set.
        set_current_ir_graph(graph);
        
        BlockScopeScpPtr blockScope;
        
        // On the const graph, blocks shouldn't matter. We don't even have a
        // block builder, to retrieve blocks from.
        if (!isConstGraph())
        {
            ir_node* block = get_cur_block();
            
            if (isa<llvm::Instruction>(value))
            {
                const llvm::Instruction* inst = cast<llvm::Instruction>(value);
                
                // Make sure the correct block is set.
                block = blockBuilder->retrieve(inst->getParent());
                assert((block != 0) && "Missing block");
            }
            else if (isa<llvm::ConstantExpr>(value))
            {
                // Constant expressions have no side-effects and can thus be moved
                // to the entry block. Note that there is always one entry block
                // that is being entered by the start block, due to the way LLVM
                // handles the entry block. Also note, that this is the only time,
                // the entry block is entered. It behaves much like firms start
                // block, but it is a usual block.
                // Moving constant expressions there is in fact necessary, to allow
                // re-using the cached value throughout the blocks of the graph,
                // because unlike instructions, equal constants (can) point to the
                // same value in LLVM and the cached node is therefore re-used.
                block = blockBuilder->getEntryBlock();
            }
            
            blockScope.reset(new BlockScope(block));
        }

        /* ================================================================== */
        /* =              Instructions OR constant expressions              = */
        /* ================================================================== */
        
        // According to LLVM docs, getValueID() shouldn't be used, to determine
        // the value type. Also instructions can be many values above the value
        // of llvm::Value::InstructionValTy, so a switch can't be used.
        
        if (isa<llvm::Instruction>(value) || isa<llvm::ConstantExpr>(value))
        {
            const llvm::Operator* valueOp = cast<llvm::Operator>(value);

            log::debug << "Building " << llvm::Instruction::getOpcodeName(
                valueOp->getOpcode()) << " value";
            
            if (value->hasName())
            {
                log::debug << " \"" << value->getNameStr() << "\"";
            }
            log::debug << log::end;
            
            switch (valueOp->getOpcode())
            {
            /* ========================= Arithmetic ========================= */
            case llvm::Instruction::FAdd:
            case llvm::Instruction::Add:      return buildAdd (valueOp);
            case llvm::Instruction::FSub:
            case llvm::Instruction::Sub:      return buildSub (valueOp);
            case llvm::Instruction::FMul:
            case llvm::Instruction::Mul:      return buildMul (valueOp);
            case llvm::Instruction::SDiv:     return buildDiv (valueOp, false);
            case llvm::Instruction::UDiv:     return buildDiv (valueOp, true);
            case llvm::Instruction::SRem:     return buildRem (valueOp, false);
            case llvm::Instruction::URem:     return buildRem (valueOp, true);
            case llvm::Instruction::FDiv:     return buildFDiv(valueOp);
            case llvm::Instruction::ICmp:     return buildICmp(valueOp);
            case llvm::Instruction::FCmp:     return buildFCmp(valueOp);
            
            /* ========================== Bitwise =========================== */
            case llvm::Instruction::And:      return buildAnd (valueOp);
            case llvm::Instruction::Or:       return buildOr  (valueOp);
            case llvm::Instruction::Xor:      return buildXor (valueOp);
            case llvm::Instruction::Shl:      return buildShl (valueOp);
            case llvm::Instruction::AShr:     return buildShr (valueOp, false);
            case llvm::Instruction::LShr:     return buildShr (valueOp, true);
            
            /* ======================== Conversions ========================= */
            case llvm::Instruction::SExt:     return buildSExt    (valueOp);
            case llvm::Instruction::ZExt:     return buildZExt    (valueOp);
            case llvm::Instruction::Trunc:    return buildTrunc   (valueOp);
            case llvm::Instruction::SIToFP:   return buildSIToFP  (valueOp);
            case llvm::Instruction::UIToFP:   return buildUIToFP  (valueOp);
            case llvm::Instruction::FPToSI:   return buildFPToSI  (valueOp);
            case llvm::Instruction::FPToUI:   return buildFPToUI  (valueOp);
            case llvm::Instruction::FPExt:    return buildFPExt   (valueOp);
            case llvm::Instruction::FPTrunc:  return buildFPTrunc (valueOp);
            case llvm::Instruction::PtrToInt: return buildPtrToInt(valueOp);
            case llvm::Instruction::IntToPtr: return buildIntToPtr(valueOp);

            // TODO: Bitcast for constants in case of alloc/store/load.
            case llvm::Instruction::BitCast:
                return buildBitCast(valueOp);
              
            case llvm::Instruction::GetElementPtr:
                return buildGetPtr(cast<llvm::GEPOperator>(valueOp));
                
            /* ======================= Miscellaneous ======================== */
            case llvm::Instruction::Select:
                return buildSelect(valueOp);
            }
        }

        /* ================================================================== */
        /* =                       Instructions ONLY                        = */
        /* ================================================================== */
        
        if (isa<llvm::Instruction>(value))
        {
            assert(!isConstGraph() && "Illegal constant instruction graph");
            const llvm::Instruction* inst = cast<llvm::Instruction>(value);
            
            switch (inst->getOpcode())
            {
            /* ======================== Control flow ======================== */
            case llvm::Instruction::Call:
                return buildCall(cast<llvm::CallInst>(inst));
                
            case llvm::Instruction::Ret:
                return buildReturn(cast<llvm::ReturnInst>(inst));
                
            case llvm::Instruction::Br:
                return buildBranch(cast<llvm::BranchInst>(inst));
                
            case llvm::Instruction::Switch:
                return buildSwitch(cast<llvm::SwitchInst>(inst));
                
            case llvm::Instruction::PHI:
                return buildPhiProxy(cast<llvm::PHINode>(inst));
                
            case llvm::Instruction::Unreachable:
                return buildUnreachable(cast<llvm::UnreachableInst>(inst));
                
            /* =========================== Memory =========================== */
            case llvm::Instruction::Alloca:
                return buildAlloca(cast<llvm::AllocaInst>(inst));
                
            case llvm::Instruction::Load:
                return buildLoad(cast<llvm::LoadInst>(inst));
                
            case llvm::Instruction::Store:
                return buildStore(cast<llvm::StoreInst>(inst));
                
            /* ========================= Aggregates ========================= */
            case llvm::Instruction::ExtractValue:
                return buildExtractValue(cast<llvm::ExtractValueInst>(inst));
                
            case llvm::Instruction::InsertValue:
                return buildInsertValue(cast<llvm::InsertValueInst>(inst));
                
            /* ===================== Variadic Arguments ===================== */
            case llvm::Instruction::VAArg:
                return buildVAArg(cast<llvm::VAArgInst>(inst));
            }
        }
        // --\ if/else continues below
        //   v
        
        /* ================================================================== */
        /* =                           Constants                            = */
        /* ================================================================== */
        
        else if (isa<llvm::ConstantPointerNull>(value))
        {
            return buildNullPtr(cast<llvm::ConstantPointerNull>(value));
        }
        else if (isa<llvm::ConstantInt>(value))
        {
            return buildInteger(cast<llvm::ConstantInt>(value));
        }
        else if (isa<llvm::ConstantFP>(value))
        {
            return buildFloat(cast<llvm::ConstantFP>(value));
        }
        else if (isa<llvm::GlobalValue>(value))
        {
            return buildPointer(cast<llvm::GlobalValue>(value));
        }
        else if (isa<llvm::UndefValue>(value))
        {
            return buildUndef(cast<llvm::UndefValue>(value));
        }
        else if (isa<llvm::ConstantArray>(value))
        {
            return buildArray(cast<llvm::ConstantArray>(value));
        }
        else if (isa<llvm::ConstantStruct>(value))
        {
            return buildStruct(cast<llvm::ConstantStruct>(value));
        }
        // --\ if/else continues below
        //   v
        
        /* ================================================================== */
        /* =                         Miscellaneous                          = */
        /* ================================================================== */
            
        else if (isa<llvm::Argument>(value))
        {
            assert(!isConstGraph() && "Illegal constant instruction graph");
            return buildArgument(cast<llvm::Argument>(value));
        }
        
        // Being here, the value seems not to be convertible.  
        std::ostringstream errorStream;
        errorStream << "Unsupported value \"";
        value->print(errorStream);
        errorStream << "\"";
        
        throw NotImplementedException(errorStream.str());
    }

    bool NodeBuilder::isConstGraph()
    {
        return graph == get_const_code_irg();
    }
}
