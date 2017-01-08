#include "../Builders/NodeBuilder.hpp"

#include <llvm/Support/Casting.h>
#include <llvm/Instruction.h>
#include <llvm/Instructions.h>
#include <llvm/Operator.h>
#include <libfirm/firm.h>
#include "../Typedef/Pointer.hpp"
#include "../Builders/TypeBuilder.hpp"
#include "../Util/Logging.hpp"
#include "../Util/Casting.hpp"
#include "../Util/TypeInfo.hpp"
#include "../Context.hpp"
#include "../Exceptions/NotSupportedException.hpp"
#include "../Exceptions/NotImplementedException.hpp"
using namespace boost;
using llvm::isa;
using llvm::cast;

namespace ltf
{
    /* ====================================================================== */
    /* =                            Conversions                             = */
    /* ====================================================================== */
    
    // Conversions are merely passed to the LLVM-like casting functions.
    
    ir_node* NodeBuilder::buildZExt(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        ir_mode* mode  = ti::getBaseMode(valueOp->getType());
        int      width = ti::getWidth(valueOp->getOperand(0)->getType());
        return ac::ZExt(value, width, mode);
    }
    
    ir_node* NodeBuilder::buildSExt(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        ir_mode* mode  = ti::getBaseMode(valueOp->getType());
        int      width = ti::getWidth(valueOp->getOperand(0)->getType());
        return ac::SExt(value, width, mode);
    }
    
    ir_node* NodeBuilder::buildTrunc(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        ir_mode* mode  = ti::getBaseMode(valueOp->getType());
        return ac::trunc(value, mode);
    }
    
    ir_node* NodeBuilder::buildSIToFP(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        ir_mode* mode  = ti::getBaseMode(valueOp->getType());
        int      width = ti::getWidth(valueOp->getOperand(0)->getType());
        return ac::SIToFP(value, width, mode);
    }
    
    ir_node* NodeBuilder::buildUIToFP(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        ir_mode* mode  = ti::getBaseMode(valueOp->getType());
        int      width = ti::getWidth(valueOp->getOperand(0)->getType());
        return ac::UIToFP(value, width, mode);
    }
    
    ir_node* NodeBuilder::buildFPToSI(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        ir_mode* mode  = ti::getBaseMode(valueOp->getType());
        return ac::FPToSI(value, mode);
    }
    
    ir_node* NodeBuilder::buildFPToUI(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        ir_mode* mode  = ti::getBaseMode(valueOp->getType());
        return ac::FPToUI(value, mode);
    }
    
    ir_node* NodeBuilder::buildFPExt(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        ir_mode* mode  = ti::getBaseMode(valueOp->getType());
        return ac::FPExt(value, mode);
    }
    
    ir_node* NodeBuilder::buildFPTrunc(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        ir_mode* mode  = ti::getBaseMode(valueOp->getType());
        return ac::FPTrunc(value, mode);
    }
    
    ir_node* NodeBuilder::buildPtrToInt(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        ir_mode* mode  = ti::getBaseMode(valueOp->getType());
        int      width = ti::getWidth(valueOp->getType());
        return ac::ptrToInt(value, mode, width);
    }
    
    ir_node* NodeBuilder::buildIntToPtr(const llvm::Operator* valueOp)
    {
        ir_node* value = retrieve(valueOp->getOperand(0));
        int      width = ti::getWidth(valueOp->getOperand(0)->getType());
        return ac::intToPtr(value, width);
    }
    
    /* ====================================================================== */
    /* =                              Bitcast                               = */
    /* ====================================================================== */
    
    // [TODO] constant bitcast?
    ir_node* NodeBuilder::buildBitCast(const llvm::Operator* valueOp)
    {        
        // Determine the casted modes.
        const llvm::Type* srcType = valueOp->getOperand(0)->getType();
        const llvm::Type* dstType = valueOp->getType();
        
        if (!ti::isAtom(srcType) || !ti::isAtom(dstType))
        {
            throw NotSupportedException("Non-atomic bitcast");
        }
        
        ir_mode* srcMode = ti::getBaseMode(srcType);
        ir_mode* dstMode = ti::getBaseMode(dstType);
        ir_node* srcNode = retrieve(valueOp->getOperand(0));
        
        assert(((srcMode != 0) && (dstMode != 0)) &&
            "Only atomic values can be bitcast.");

        // No-op shortcut. This frequently happens for pointers.
        if (srcMode == dstMode)
        {
            log::debug << "No-op bitcast ignored" << log::end;
            return srcNode;
        }
        
        if (isConstGraph())
        {
            throw NotImplementedException("No real bitcast support for constants");
        }
        
        log::debug << "Replacing bitcast by alloc/store/load/free" << log::end;
        
        // Allocate some memory on the stack.
        ir_type* fSrcType  = context.retrieveType(srcType);
        ir_node* oneNode   = new_Const(new_tarval_from_long(1, mode_Iu));
        ir_node* allocNode = new_Alloc(get_store(), oneNode, fSrcType, stack_alloc);
        ir_node* ptrNode   = new_Proj(allocNode, mode_P, pn_Alloc_res);
        set_store(new_Proj(allocNode, mode_M, pn_Alloc_M));
        
        // Write the value to it.
        ir_node* storeNode = new_Store(get_store(), ptrNode, srcNode, cons_none);
        set_store(new_Proj(storeNode, mode_M, pn_Store_M));
        
        // Load the value with the requested mode.
        ir_node* loadNode = new_Load(get_store(), ptrNode, dstMode, cons_none);
        ir_node* resNode  = new_Proj(loadNode, dstMode, pn_Load_res);
        set_store(new_Proj(loadNode, mode_M, pn_Load_M));
        
        // Free the memory again.
        ir_node* freeNode = new_Free(get_store(), ptrNode, oneNode, fSrcType, stack_alloc);
        set_store(freeNode);
        
        return resNode;
    }
}
