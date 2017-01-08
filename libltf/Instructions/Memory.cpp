#include "../Builders/NodeBuilder.hpp"

#include <climits>
#include <boost/foreach.hpp>
#include <llvm/Support/Casting.h>
#include <llvm/Instructions.h>
#include <llvm/Operator.h>
#include <libfirm/firm.h>
#include "../Config.hpp"
#include "../Builders/TypeBuilder.hpp"
#include "../Builders/FrameBuilder.hpp"
#include "../Util/Logging.hpp"
#include "../Util/LlvmTools.hpp"
#include "../Context.hpp"
#include "../Util/Casting.hpp"
#include "../Util/TypeInfo.hpp"
#include "../Exceptions/NotSupportedException.hpp"
#include "../Exceptions/NotImplementedException.hpp"
using llvm::isa;
using llvm::cast;

namespace ltf
{
    // [TODO] Free-Instruktion.
    
    /* ====================================================================== */
    /* =                               Alloca                               = */
    /* ====================================================================== */
    
    // [*]
    // [TODO] alignment
    ir_node* NodeBuilder::buildAlloca(const llvm::AllocaInst* inst)
    {
        // Lookup the frame, if there is an entity for this instruction.
        ir_entity* frameEntity = frameBuilder->retrieve(inst);
        
        if (frameEntity != 0)
        {
            // Create a sel node for the frame entity.
            return new_simpleSel(new_NoMem(), get_irg_frame(graph), frameEntity);
        }

        // Get allocation type and size.
        const llvm::Type*  type      = inst->getAllocatedType();
        ir_type*           fType     = context.retrieveType(type);
        const llvm::Value* sizeValue = inst->getArraySize();
        ir_node*           sizeNode  = retrieve(sizeValue);
        sizeNode = ac::intToUBase(sizeValue->getType(), sizeNode);
        
        // Construct a firm node.
        ir_node* allocNode = new_Alloc(get_store(), sizeNode, fType, stack_alloc);
        
        set_store(new_Proj(allocNode, mode_M, pn_Alloc_M));
        return new_Proj(allocNode, mode_P, pn_Alloc_res);
    }
    
    /* ====================================================================== */
    /* =                                Load                                = */
    /* ====================================================================== */
    
    // [atom] | [tuple]
    // [TODO] alignment
    ir_node* NodeBuilder::buildLoad(const llvm::LoadInst* inst)
    {
        if (!ti::isAtom(inst->getType()) && !ti::isTuple(inst->getType()))
        {
            throw NotSupportedException("Non-atomic and non-tuple load");
        }
        
        // Retrieve the load pointer.
        const llvm::Value* ptrValue = inst->getPointerOperand();
        ir_node*           ptrNode  = retrieve(ptrValue);

        // Use a separate method to load tuples. It's more complex.
        if (ti::isTuple(inst->getType()))
        {
            return buildTupleLoad(ptrNode, inst->getType());
        }
        
        // Construct the load node.
        ir_mode* loadMode = ti::getBaseMode(inst->getType());
        ir_node* loadNode = new_Load(get_store(), ptrNode, loadMode, cons_none);
        set_store(new_Proj(loadNode, mode_M, pn_Load_M));
        
        // Transfer volatility.
        if (inst->isVolatile())
        {
            set_Load_volatility(loadNode, volatility_is_volatile);
        }
        
        return new_Proj(loadNode, loadMode, pn_Load_res);
    }
    
    /* ====================================================================== */
    /* =                               Store                                = */
    /* ====================================================================== */
    
    // [atom] | [tuple]
    // [TODO] alignment
    ir_node* NodeBuilder::buildStore(const llvm::StoreInst* inst)
    {        
        const llvm::PointerType* ptrType = cast<llvm::PointerType>(
            inst->getPointerOperand()->getType()
        );
        
        const llvm::Type* storeType = ptrType->getElementType();
        
        if (!ti::isAtom(storeType) && !ti::isTuple(storeType))
        {
            throw NotSupportedException("Non-atomic and non-tuple store");
        }
     
        // Retrieve pointer and value to store.
        const llvm::Value* ptrValue  = inst->getPointerOperand();
        ir_node*           ptrNode   = retrieve(ptrValue);
        ir_node*           valueNode = retrieve(inst->getOperand(0));
        
        // Use a separate method to store tuples. It's more complex.
        if (ti::isTuple(storeType))
        {
            buildTupleStore(valueNode, ptrNode, storeType);
            return 0;
        }
        
        // Use the base type to store values. Normalization is not needed.
        valueNode = ac::atomToBase(ptrType->getElementType(), valueNode, false);

        // Construct the store node.
        ir_node* storeNode = new_Store(get_store(), ptrNode, valueNode, cons_none);
        set_store(new_Proj(storeNode, mode_M, pn_Store_M));
        
        // Transfer volatility.
        if (inst->isVolatile())
        {
            set_Store_volatility(storeNode, volatility_is_volatile);
        }
        
        return 0;
    }
    
    /* ====================================================================== */
    /* =                           Getelementptr                            = */
    /* ====================================================================== */
    
    ir_node* NodeBuilder::buildGetPtr(ir_node* valueNode, const llvm::Type*
        valueType, const ValueVect& indices)
    {
        // Since this may be part of a constant expression, the sel nodes below
        // only use no-mem as store, to allow moving the expression into the
        // start block.

        // Iterate the indices.
        BOOST_FOREACH (llvm::Value* idx, indices)
        {
            ir_node* idxNode = retrieve(idx);
            
            // Determine how to retrieve the element using the index.
            switch (valueType->getTypeID())
            {
            /* ============================================================== */
            /* =                    Pointer arithmetics                     = */
            /* ============================================================== */
            case llvm::Type::PointerTyID:
            {
                // Get the firm type of the element pointed to.
                const llvm::PointerType* ptrType = cast<llvm::PointerType>(valueType);
                
                const llvm::Type* type     = ptrType->getElementType();
                ir_type*          fType    = context.retrieveType(type);
                int               typeSize = get_type_size_bytes(fType);
                
                // Add index times the element size.
                idxNode = ac::intToUBase(idx->getType(), idxNode);
                
                ir_node* sizeNode = new_Const_long(mode_Iu, typeSize);
                ir_node* mulNode  = new_Mul(idxNode, sizeNode, mode_Iu);
                ir_node* addNode  = new_Add(valueNode, mulNode, mode_P);
                
                // Update the value and its type to match the resulting value.
                valueType = type;
                valueNode = addNode;
                
                break;
            }
            
            /* ============================================================== */
            /* =                           Arrays                           = */
            /* ============================================================== */
            case llvm::Type::ArrayTyID:
            {
                // Get the firm type of the array and the element entity.
                const llvm::ArrayType* arrayType = cast<llvm::ArrayType>(valueType);

                // Update value and type.
                valueType = arrayType->getElementType();
                
#ifdef GEP_POINTER_ARITHMETIC
                const llvm::Type* elementType  = arrayType->getElementType();
                ir_type*          fElementType = context.retrieveType(elementType);
                int               typeSize     = get_type_size_bytes(fElementType);
                
                // Add index times the element size.
                idxNode = ac::intToUBase(idx->getType(), idxNode);
                
                ir_node* sizeNode = new_Const_long(mode_Iu, typeSize);
                ir_node* mulNode  = new_Mul(idxNode, sizeNode, mode_Iu);
                valueNode = new_Add(valueNode, mulNode, mode_P);
#else
                ir_type*   fArrayType = context.retrieveType(arrayType);
                ir_entity* entity     = get_array_element_entity(fArrayType);
                
                // Create a sel node with the given index.
                ir_node* idxNodes[1] = { idxNode };
                valueNode = new_Sel(
                    new_NoMem(), valueNode, 1, idxNodes, entity
                );
#endif
                break;
            }
            
            /* ============================================================== */
            /* =                         Structures                         = */
            /* ============================================================== */
            case llvm::Type::StructTyID:
            {
                // LLVM allows only i32 constants as indices for structures.
                // That is good, because we need the index as int in here.
                assert(isa<llvm::ConstantInt>(idx) && "Invalid struct index");
                
                // Get the firm type of the struct.
                const llvm::StructType*  structType = cast<llvm::StructType>(valueType);
                const llvm::ConstantInt* idxConst   = cast<llvm::ConstantInt>(idx);
                
                // Retrieve the entity of the target field.
                assert((idxConst->getLimitedValue() <= INT_MAX) &&
                    "Struct index out of bounds");
                
                int        idxInt      = static_cast<int>(idxConst->getLimitedValue());
                ir_type*   fStructType = context.retrieveType(structType);
                ir_entity* entity      = get_struct_member(fStructType, idxInt);
      
                // Update value and type.
                valueType = structType->getElementType(idxInt);
                
#ifdef GEP_POINTER_ARITHMETIC
                // Add the entities offset to the pointer.
                int      offset  = get_entity_offset(entity);
                ir_node* offNode = new_Const_long(mode_P, offset);
                valueNode = new_Add(valueNode, offNode, mode_P);
#else
                // Construct a sel node to get the entity.
                valueNode = new_simpleSel(new_NoMem(), valueNode, entity);
#endif
                
                break;
            }
                
            default:
                throw NotImplementedException("Unsupported compound type");
            }
        }
        
        return valueNode;
    }
    
    // [ptr]
    // This is no real memory access but simply pointer arithmetics on steroids.
    ir_node* NodeBuilder::buildGetPtr(const llvm::GEPOperator* valueOp)
    {
        // Convert the pointer.
        const llvm::Type* valueType = valueOp->getPointerOperandType();
        ir_node*          valueNode = retrieve(valueOp->getPointerOperand());
        valueNode = ac::atomToBase(valueType, valueNode);
        
        ValueVect indices;
        indices.reserve(valueOp->getNumIndices());
        
        // Convert the indices.
        for (llvm::Operator::const_op_iterator it = valueOp->idx_begin(),
            eit = valueOp->idx_end(); it != eit; ++it)
        {
            indices.push_back(it->get());
        }
        
        return buildGetPtr(valueNode, valueType, indices);
    }
}
