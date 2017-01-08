#include "../Builders/NodeBuilder.hpp"

#include <llvm/Support/Casting.h>
#include <llvm/Target/TargetData.h>
#include <llvm/Operator.h>
#include <llvm/Constants.h>
#include <llvm/Instructions.h>
#include <llvm/DerivedTypes.h>
#include <libfirm/firm.h>
#include "../Builders/TypeBuilder.hpp"
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
    /* ====================================================================== */
    /* =                      Addition and subtraction                      = */
    /* ====================================================================== */

    // ([atom], [atom]) -> [atom]
    ir_node* NodeBuilder::buildAdd(const llvm::Operator* valueOp)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isAtom(value1->getType()) || !ti::isAtom(value2->getType()))
        {
            throw NotImplementedException("Non-atomic (f-)add");
        }
        
        // The high-order bits of a modulo m type are like adding a multiple
        // of 2^m. So we get:
        //
        // a + r2^m + b + s2^m = a + b + (r+s)2^m = a + b + t2^m
        //
        // So they will only affect the new high-order bits and we don't need
        // to normalize the input operands.
        
        ir_node* node1 = ac::atomToBase(value1->getType(), retrieve(value1), false);
        ir_node* node2 = ac::atomToBase(value2->getType(), retrieve(value2), false);
        assert(ti::modeIsEqual(node1, node2));
        
        return new_Add(node1, node2, get_irn_mode(node1));
    }
    
    // ([atom], [atom]) -> [atom]
    ir_node* NodeBuilder::buildSub(const llvm::Operator* valueOp)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isAtom(value1->getType()) || !ti::isAtom(value2->getType()))
        {
            throw NotImplementedException("Non-atomic (f-)sub");
        }

        // No normalization needed, like with addition.
        ir_node* node1 = ac::atomToBase(value1->getType(), retrieve(value1), false);
        ir_node* node2 = ac::atomToBase(value2->getType(), retrieve(value2), false);
        assert(ti::modeIsEqual(node1, node2));
        
        return new_Sub(node1, node2, get_irn_mode(node1));
    }
    
    // ([atom], [atom]) -> [atom]
    ir_node* NodeBuilder::buildMul(const llvm::Operator* valueOp)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isAtom(value1->getType()) || !ti::isAtom(value2->getType()))
        {
            throw NotImplementedException("Non-atomic (f-)mul");
        }

        // Modulo m can be ignored just like it's done for addition:
        //
        // (a + r2^m) * (b + s2^m) = ab + as2^m + br2^m + rs2^2m
        //                         = ab + (as+br+rs2^m)2^m = ab + r2^m
        //
        // It will just affect high-order bits.
        
        ir_node* node1 = ac::atomToBase(value1->getType(), retrieve(value1), false);
        ir_node* node2 = ac::atomToBase(value2->getType(), retrieve(value2), false);
        assert(ti::modeIsEqual(node1, node2));
        
        return new_Mul(node1, node2, get_irn_mode(node1));
    }
    
    /* ====================================================================== */
    /* =                    Multiplication and division                     = */
    /* ====================================================================== */
    
    // ([int-atom], [int-atom]) -> [int-atom]
    ir_node* NodeBuilder::buildDiv(const llvm::Operator* valueOp, bool isUnsigned)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isIntAtom(value1->getType()) || !ti::isIntAtom(value2->getType()))
        {
            throw NotImplementedException("Non-int-atomic (u-/s-)div");
        }

        // Be careful and always normalize here. The same argument as for the
        // other arithmetical operations doesn't apply here, because we can't
        // simply split a fraction for integer division:
        //
        // 1 + 1   1   1
        // ----- = - + - = 0 --> this is surely wrong.
        //   2     2   2
        
        ir_node* node1 = retrieve(value1);
        ir_node* node2 = retrieve(value2);
        
        // Make both operands either signed or unsigned.
        if (isUnsigned)
        {
            node1 = ac::intToUBase(value1->getType(), node1);
            node2 = ac::intToUBase(value2->getType(), node2);
        }
        else
        {
            node1 = ac::intToSBase(value1->getType(), node1);
            node2 = ac::intToSBase(value2->getType(), node2);
        }
        
        assert(ti::modeIsEqual(node1, node2));
        
        // Construct the actual node.
        ir_node* pinNode = new_Pin(new_NoMem());
        ir_node* divNode = new_Div(
            pinNode, node1, node2, get_irn_mode(node1), op_pin_state_pinned
        );
        
        return new_Proj(divNode, get_irn_mode(node1), pn_Div_res);
    }

    // ([int-atom], [int-atom]) -> [int-atom]
    ir_node* NodeBuilder::buildRem(const llvm::Operator* valueOp, bool isUnsigned)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isIntAtom(value1->getType()) || !ti::isIntAtom(value2->getType()))
        {
            throw NotImplementedException("Non-int-atomic (u-/s-)rem");
        }

        ir_node* node1 = retrieve(value1);
        ir_node* node2 = retrieve(value2);
        
        // Make both operands either signed or unsigned.
        if (isUnsigned)
        {
            node1 = ac::intToUBase(value1->getType(), node1);
            node2 = ac::intToUBase(value2->getType(), node2);
        }
        else
        {
            node1 = ac::intToSBase(value1->getType(), node1);
            node2 = ac::intToSBase(value2->getType(), node2);
        }
        
        assert(ti::modeIsEqual(node1, node2));
        
        // Construct the actual node.
        ir_node* pinNode = new_Pin(new_NoMem());
        ir_node* divNode = new_Mod(
            pinNode, node1, node2, get_irn_mode(node1), op_pin_state_pinned
        );
        
        return new_Proj(divNode, get_irn_mode(node1), pn_Div_res);
    }
    
    // ([float], [float]) -> [float]
    ir_node* NodeBuilder::buildFDiv(const llvm::Operator* valueOp)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isFloat(value1->getType()) || !ti::isFloat(value2->getType()))
        {
            throw NotImplementedException("Non-float (f-)div");
        }

        ir_node* node1 = retrieve(value1);
        ir_node* node2 = retrieve(value2);
        assert(ti::modeIsEqual(node1, node2));

        // Construct the actual quot node (alas pinned).
        ir_node* pinNode  = new_Pin(new_NoMem());
        ir_node* quotNode = new_Quot(
            pinNode, node1, node2, get_irn_mode(node1), op_pin_state_pinned
        );
        
        return new_Proj(quotNode, get_irn_mode(node1), pn_Quot_res);
    }
    
    /* ====================================================================== */
    /* =                            Comparisons                             = */
    /* ====================================================================== */
    
    namespace
    {
        llvm::CmpInst::Predicate getPredicate(const llvm::Operator* valueOp)
        {
            // Get the comparison type. Alas this is a bit ugly.
            if (isa<llvm::ConstantExpr>(valueOp))
            {
                return static_cast<llvm::CmpInst::Predicate>(
                    cast<llvm::ConstantExpr>(valueOp)->getPredicate()
                );
            }
            
            return cast<llvm::CmpInst>(valueOp)->getPredicate();
        }
    }
    
    // ([int-atom] | [ptr], [int-atom] | [ptr]) -> b
    ir_node* NodeBuilder::buildICmp(const llvm::Operator* valueOp)
    {
        const llvm::Type* type1 = valueOp->getOperand(0)->getType();
        const llvm::Type* type2 = valueOp->getOperand(1)->getType();
        
        if (!(ti::isIntAtom(type1) || ti::isPtr(type1)) &&
            !(ti::isIntAtom(type2) || ti::isPtr(type2)))
        {
            throw NotImplementedException("Non-int-atomic or pointer icmp");
        }
        
        llvm::CmpInst::Predicate predicate = getPredicate(valueOp);
        bool   isUnsigned = false;
        pn_Cmp projNum;
        
        // Determine the projection to use and whether to do an unsigned conversion.
        switch (predicate)
        {
        /* ============================= Signed ============================= */
        case llvm::CmpInst::ICMP_EQ:  projNum = pn_Cmp_Eq; break;
        case llvm::CmpInst::ICMP_NE:  projNum = pn_Cmp_Lg; break;
        case llvm::CmpInst::ICMP_SGT: projNum = pn_Cmp_Gt; break;
        case llvm::CmpInst::ICMP_SGE: projNum = pn_Cmp_Ge; break;
        case llvm::CmpInst::ICMP_SLT: projNum = pn_Cmp_Lt; break;
        case llvm::CmpInst::ICMP_SLE: projNum = pn_Cmp_Le; break;
        
        /* ============================ Unsigned ============================ */
        case llvm::CmpInst::ICMP_UGT: projNum = pn_Cmp_Gt; isUnsigned = true; break;
        case llvm::CmpInst::ICMP_UGE: projNum = pn_Cmp_Ge; isUnsigned = true; break;
        case llvm::CmpInst::ICMP_ULT: projNum = pn_Cmp_Lt; isUnsigned = true; break;
        case llvm::CmpInst::ICMP_ULE: projNum = pn_Cmp_Le; isUnsigned = true; break;
        
        default: throw NotSupportedException("Unsupported comparison predicate");
        }
        
        ir_node* node1 = retrieve(valueOp->getOperand(0));
        ir_node* node2 = retrieve(valueOp->getOperand(1));
        
        // Obtain an integer mode that matches the pointer width.
        ir_mode* ptrIntMode = ti::getBaseMode(
            context.getTargetData()->getIntPtrType(llvm::getGlobalContext())
        );
        
        // Ensure the mode has the correct signedness.
        if (isUnsigned) ptrIntMode = ti::getUnsignedMode (ptrIntMode);
        else            ptrIntMode = ti::getSignedMode   (ptrIntMode);
        
        // Cast both operands to the appropriate modes.
        if (ti::isPtr(type1)) node1 = ac::ptrToInt(node1, ptrIntMode, 0);
        else if (isUnsigned)  node1 = ac::intToUBase(type1, node1);
        else                  node1 = ac::intToSBase(type1, node1);
        
        if (ti::isPtr(type2)) node2 = ac::ptrToInt(node2, ptrIntMode, 0);
        else if (isUnsigned)  node2 = ac::intToUBase(type2, node2);
        else                  node2 = ac::intToSBase(type2, node2);

        // Create the comparison node and appropriate proj.
        ir_node* cmpNode  = new_Cmp(node1, node2);
        return new_Proj(cmpNode, mode_b, projNum);
    }
    
    // ([float], [float]) -> b
    ir_node* NodeBuilder::buildFCmp(const llvm::Operator* valueOp)
    {
        const llvm::Type* type1 = valueOp->getOperand(0)->getType();
        const llvm::Type* type2 = valueOp->getOperand(1)->getType();

        if (!ti::isFloat(type1) || !ti::isFloat(type2))
        {
            throw NotImplementedException("Non-float fcmp");
        }
        
        llvm::CmpInst::Predicate predicate = getPredicate(valueOp);
        pn_Cmp projNum;
        
        // Determine the projection to use and whether to do an unsigned conversion.
        switch (predicate)
        {
        /* ============================ Ordered ============================= */
        case llvm::CmpInst::FCMP_OEQ: projNum = pn_Cmp_Eq; break;
        case llvm::CmpInst::FCMP_ONE: projNum = pn_Cmp_Lg; break;
        case llvm::CmpInst::FCMP_OGT: projNum = pn_Cmp_Gt; break;
        case llvm::CmpInst::FCMP_OGE: projNum = pn_Cmp_Ge; break;
        case llvm::CmpInst::FCMP_OLT: projNum = pn_Cmp_Lt; break;
        case llvm::CmpInst::FCMP_OLE: projNum = pn_Cmp_Le; break;
        
        /* =========================== Unordered ============================ */
        case llvm::CmpInst::FCMP_UEQ: projNum = pn_Cmp_Ue;  break;
        case llvm::CmpInst::FCMP_UNE: projNum = pn_Cmp_Ne;  break;
        case llvm::CmpInst::FCMP_UGT: projNum = pn_Cmp_Ug;  break;
        case llvm::CmpInst::FCMP_UGE: projNum = pn_Cmp_Uge; break;
        case llvm::CmpInst::FCMP_ULT: projNum = pn_Cmp_Ul;  break;
        case llvm::CmpInst::FCMP_ULE: projNum = pn_Cmp_Ule; break;
        
        /* ========================= Miscellaneous ========================== */
        case llvm::CmpInst::FCMP_TRUE:  projNum = pn_Cmp_True;  break;
        case llvm::CmpInst::FCMP_FALSE: projNum = pn_Cmp_False; break;
        case llvm::CmpInst::FCMP_UNO:   projNum = pn_Cmp_Uo;    break;
        case llvm::CmpInst::FCMP_ORD:   projNum = pn_Cmp_Leg;   break;
        
        default: throw NotSupportedException("Unsupported comparison predicate");
        }
        
        ir_node* node1 = retrieve(valueOp->getOperand(0));
        ir_node* node2 = retrieve(valueOp->getOperand(1));
        assert(ti::modeIsEqual(node1, node2));

        // Create the comparison node and appropriate proj.
        ir_node* cmpNode  = new_Cmp(node1, node2);
        return new_Proj(cmpNode, mode_b, projNum);
    }
}
