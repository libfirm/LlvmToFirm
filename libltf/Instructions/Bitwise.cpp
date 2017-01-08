#include "../Builders/NodeBuilder.hpp"

#include <cassert>
#include <llvm/Operator.h>
#include <llvm/DerivedTypes.h>
#include <llvm/Support/Casting.h>
#include <libfirm/firm.h>
#include "../Builders/TypeBuilder.hpp"
#include "../Context.hpp"
#include "../Util/Casting.hpp"
#include "../Util/TypeInfo.hpp"
#include "../Util/Logging.hpp"
#include "../Exceptions/NotImplementedException.hpp"
using llvm::cast;

namespace ltf
{
    /* ====================================================================== */
    /* =                              Logical                               = */
    /* ====================================================================== */
    
    // ([int-atom], [int-atom]) -> [int-atom]
    ir_node* NodeBuilder::buildAnd(const llvm::Operator* valueOp)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isIntAtom(value1->getType()) || !ti::isIntAtom(value2->getType()))
        {
            throw NotImplementedException("Non-int-atomic and");
        }
        
        // Force mode_b, to enable firms bool optimizations.
        ir_node* node1 = ac::intToBaseOrB(value1->getType(), retrieve(value1));
        ir_node* node2 = ac::intToBaseOrB(value2->getType(), retrieve(value2));
        assert(ti::modeIsEqual(node1, node2));
        
        return new_And(node1, node2, get_irn_mode(node1));
    }
    
    // ([int-atom], [int-atom]) -> [int-atom]
    ir_node* NodeBuilder::buildOr(const llvm::Operator* valueOp)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isIntAtom(value1->getType()) || !ti::isIntAtom(value2->getType()))
        {
            throw NotImplementedException("Non-int-atomic or");
        }
        
        // Force mode_b, to enable firms bool optimizations.
        ir_node* node1 = ac::intToBaseOrB(value1->getType(), retrieve(value1));
        ir_node* node2 = ac::intToBaseOrB(value2->getType(), retrieve(value2));
        assert(ti::modeIsEqual(node1, node2));
        
        return new_Or(node1, node2, get_irn_mode(node1));
    }
    
    // ([int-atom], [int-atom]) -> [int-atom]
    ir_node* NodeBuilder::buildXor(const llvm::Operator* valueOp)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isIntAtom(value1->getType()) || !ti::isIntAtom(value2->getType()))
        {
            throw NotImplementedException("Non-int-atomic xor");
        }
        
        // Force mode_b, to enable firms bool optimizations.
        ir_node* node1 = ac::intToBaseOrB(value1->getType(), retrieve(value1));
        ir_node* node2 = ac::intToBaseOrB(value2->getType(), retrieve(value2));
        assert(ti::modeIsEqual(node1, node2));

        return new_Eor(node1, node2, get_irn_mode(node1));
    }
    
    /* ====================================================================== */
    /* =                              Shifting                              = */
    /* ====================================================================== */

    // ([int-atom], [int-atom]) -> [int-atom]
    ir_node* NodeBuilder::buildShl(const llvm::Operator* valueOp)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isIntAtom(value1->getType()) || !ti::isIntAtom(value2->getType()))
        {
            throw NotImplementedException("Non-int-atomic shl");
        }
        
        // The left operand can stay unnormalized. We shift to the left.
        ir_node* node1 = ac::intToSBase(value1->getType(), retrieve(value1), false);
        ir_node* node2 = ac::intToUBase(value2->getType(), retrieve(value2));
        
        // Firm doesn't support >32 bit shift widths. This is no problem,
        // because shifting more than the bit width is undefined and we can
        // therefore just truncate the argument down to 32 bit.
        if (ti::getBaseWidth(value2->getType()) > 32)
        {
            node2 = ac::trunc(node2, mode_Iu);
        }
        
        return new_Shl(node1, node2, get_irn_mode(node1));
    }
    
    // ([int-atom], [int-atom]) -> [int-atom]
    ir_node* NodeBuilder::buildShr(const llvm::Operator* valueOp, bool isLogical)
    {
        llvm::Value* value1 = valueOp->getOperand(0);
        llvm::Value* value2 = valueOp->getOperand(1);
        
        if (!ti::isIntAtom(value1->getType()) || !ti::isIntAtom(value2->getType()))
        {
            throw NotImplementedException("Non-int-atomic (a-)shr");
        }
        
        // Make sure, that both operands are normalized.
        ir_node* node1 = retrieve(value1);
        ir_node* node2 = ac::intToUBase(value2->getType(), retrieve(value2));

        // See shl. Firm doesn't support >32 bit shift widths.
        if (ti::getBaseWidth(value2->getType()) > 32)
        {
            node2 = ac::trunc(node2, mode_Iu);
        }
        
        // Cast the left operands signedness and the shift node, to either yield
        // a logical or an arithmetical shift.
        if (isLogical)
        {
            node1 = ac::intToUBase(value1->getType(), node1);
            return new_Shr(node1, node2, get_irn_mode(node1));
        }
        
        node1 = ac::intToSBase(value1->getType(), node1);
        return new_Shrs(node1, node2, get_irn_mode(node1));
    }
}
