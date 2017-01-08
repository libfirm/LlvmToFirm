#include "../Builders/NodeBuilder.hpp"

#include <llvm/Instructions.h>
#include <libfirm/firm.h>
#include "../Context.hpp"
#include "../Util/Logging.hpp"
#include "../Util/Casting.hpp"
#include "../Util/TypeInfo.hpp"
#include "../Exceptions/NotSupportedException.hpp"

namespace ltf
{
    // LLVM documentation basically states, that all va_arg intrinsics or
    // instructions operate on a va_list, which is target dependant. However
    // since LLVMs backend doesn't properly support va_arg yet (or didn't
    // recently), the instruction is lowered in the frontend to pointer
    // arithmetics, which in turn expects va_start to write the address of
    // the first variadic argument to the given address.
    
    namespace
    {
        unsigned int getStackAlignedSize(unsigned int size)
        {
            const backend_params* backendParams = be_get_backend_param();

            // The usual round-up alignment.
            unsigned int alignment    = backendParams->stack_param_align;
            unsigned int displacement = size % alignment; 
            
            if (displacement > 0)
            {
                size += alignment - displacement;
            }
            
            return size;
        }
    }
    
    // [ptr]
    ir_node* NodeBuilder::buildVAStart(const llvm::CallInst* inst)
    {
        if (!ti::isPtr(inst->getOperand(1)->getType()))
        {
            throw NotSupportedException("Non-pointer va_start");
        }
        
        // Get a pointer to last non-variadic argument of this function.
        ir_type*     fType       = get_entity_type(get_irg_entity(graph));
        int          index       = get_method_n_params(fType) - 1;
        ir_entity*   entity      = get_method_value_param_ent(fType, index);
        ir_node*     frameNode   = get_irg_frame(graph);
        ir_node*     ptrNode     = new_simpleSel(new_NoMem(), frameNode, entity);
        
        // Add the aligned size, to get to the first variadic parameter and
        // retrieve a normalized pointer to store to.
        ir_type*     fArgType        = get_entity_type(entity);
        unsigned int size            = get_type_size_bytes(fArgType);
        unsigned int alignedSize     = getStackAlignedSize(size);
        ir_node*     alignedSizeNode = new_Const_long(mode_Iu, alignedSize);
        ir_node*     dstPtrNode      = retrieve(inst->getOperand(1));
        
        ptrNode    = new_Add(ptrNode, alignedSizeNode, mode_P);
        dstPtrNode = ac::atomToBase(inst->getOperand(1)->getType(), dstPtrNode);

        // Store the resulting pointer.
        ir_node* storeNode = new_Store(
            get_store(), dstPtrNode, ptrNode, cons_none
        );
        set_store(new_Proj(storeNode, mode_M, pn_Store_M));

        return 0;
    }
    
    // [ptr]
    ir_node* NodeBuilder::buildVAEnd(const llvm::CallInst* inst)
    {
        if (!ti::isPtr(inst->getOperand(1)->getType()))
        {
            throw NotSupportedException("Non-pointer va_end");
        }
        
        // We can simply ignore this. The value on the stack is automatically
        // being destroyed, when the function is being left.
        return 0;
    }
    
    // ([ptr], [ptr])
    ir_node* NodeBuilder::buildVACopy(const llvm::CallInst* inst)
    {
        if (!ti::isPtr(inst->getOperand(1)->getType()) &&
            !ti::isPtr(inst->getOperand(2)->getType()))
        {
            throw NotSupportedException("Non-pointer va_copy");
        }
        
        // Just copy the pointer from one va_list to the other. First retrieve
        // both pointer nodes. Destination comes first.
        ir_node* dstPtrNode = retrieve(inst->getOperand(1));
        ir_node* srcPtrNode = retrieve(inst->getOperand(2));
        dstPtrNode = ac::atomToBase(inst->getOperand(1)->getType(), dstPtrNode);
        srcPtrNode = ac::atomToBase(inst->getOperand(2)->getType(), srcPtrNode);
        
        // And copy the pointer using load/store.
        ir_node* loadNode  = new_Load(get_store(), srcPtrNode, mode_P, cons_none);
        ir_node* valProj   = new_Proj(loadNode, mode_P, pn_Load_res);
        ir_node* memProj   = new_Proj(loadNode, mode_M, pn_Load_M);
        ir_node* storeNode = new_Store(memProj, dstPtrNode, valProj, cons_none);
        set_store(new_Proj(storeNode, mode_M, pn_Store_M));
        
        return 0;
    }
    
    // [ptr]
    ir_node* NodeBuilder::buildVAArg(const llvm::VAArgInst* inst)
    {
        if (!ti::isPtr(inst->getOperand(0)->getType()))
        {
            throw NotSupportedException("Non-pointer va_arg");
        }
        
        // Get the aligned size for the requested type and the pointer to the
        // va_list that is to be updated and queried.
        ir_type*     fType           = context.retrieveType(inst->getType());
        unsigned int size            = get_type_size_bytes(fType);
        unsigned int alignedSize     = getStackAlignedSize(size);
        ir_node*     alignedSizeNode = new_Const_long(mode_Iu, alignedSize);
        ir_node*     lstPtrNode      = retrieve(inst->getOperand(0));
        lstPtrNode = ac::atomToBase(inst->getOperand(0)->getType(), lstPtrNode);

        // Load the value, update the pointer and store it again.
        ir_node* loadNode  = new_Load(get_store(), lstPtrNode, mode_P, cons_none);
        ir_node* ptrProj   = new_Proj(loadNode, mode_P, pn_Load_res);
        ir_node* memProj   = new_Proj(loadNode, mode_M, pn_Load_M);
        ir_node* addNode   = new_Add(ptrProj, alignedSizeNode, mode_P);
        ir_node* storeNode = new_Store(memProj, lstPtrNode, addNode, cons_none);
        set_store(new_Proj(storeNode, mode_M, pn_Store_M));
        
        // Load the value at the old address and return it.
        ir_mode* loadMode    = ti::getBaseMode(inst->getType());
        ir_node* loadArgNode = new_Load(get_store(), ptrProj, loadMode, cons_none);
        ir_node* argProj     = new_Proj(loadArgNode, loadMode, pn_Load_res);
        set_store(new_Proj(loadArgNode, mode_M, pn_Load_M));
        
        return argProj;
    }
}
