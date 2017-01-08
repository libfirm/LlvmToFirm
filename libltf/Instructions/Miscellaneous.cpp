#include "../Builders/NodeBuilder.hpp"

#include <cassert>
#include <llvm/Operator.h>
#include <llvm/Argument.h>
#include <llvm/DerivedTypes.h>
#include <libfirm/firm.h>
#include "../Builders/TypeBuilder.hpp"
#include "../Util/Logging.hpp"
#include "../Util/Casting.hpp"
#include "../Util/TypeInfo.hpp"
#include "../Context.hpp"
#include "../Exceptions/NotImplementedException.hpp"
#include "../Typedef/Pointer.hpp"
using namespace boost;

namespace ltf
{
    /* ====================================================================== */
    /* =                              Argument                              = */
    /* ====================================================================== */
    
    ir_node* NodeBuilder::buildArgument(const llvm::Argument* arg)
    {
        // Basically aggregate parameters may be passed in three ways: passing
        // as pointer is trivial and the same way as in firm. If the byval
        // attribute is specified, the object pointed to is supposed to be
        // copied. This is how firm handles non-pointer aggregates by default:
        // by-value and using a pointer for passing and retrieving the data.
        // The third way directly uses aggregate values and copies them. This
        // isn't directly possible in firm, since aggregates are implemented
        // using tuples. These are serialized or deserialized using an entity
        // on the frame type, to pass them as pointer.

        // LLVM parameter        Firm parameter  Firm mode
        // --------------        --------------  ---------
        // { i32, i8 }* x        { i32, i8 }*    P
        // { i32, i8 }* x byval  { i32, i8 }     P
        // { i32, i8 }           i32, i8         P
        
        log::debug << "Building argument " << arg->getArgNo() << log::end;
        
        ir_mode* argMode = ti::getBaseMode(arg->getType());
        assert((argMode != 0) && "Couldn't determine the argument mode.");
        
        // Tuples are passed as pointer.
        if (ti::isTuple(arg->getType()))
        {
            argMode = mode_P;
        }
        
        // Access the argument node and create an appropriate proj.
        int      index      = arg->getArgNo();
        ir_node* startBlock = get_irg_start_block(get_current_ir_graph());
        ir_node* argTuple   = get_irg_args(get_current_ir_graph());
        ir_node* argNode    = new_r_Proj(argTuple, argMode, index);
        
        if (ti::isTuple(arg->getType()))
        {
            // Deserialize the structure from memory.
            argNode = buildTupleLoad(argNode, arg->getType());
        }
        
        return argNode;
    }
    
    /* ====================================================================== */
    /* =                               Select                               = */
    /* ====================================================================== */

    // ([bool], [atom], [atom]) -> [atom]
    ir_node* NodeBuilder::buildSelect(const llvm::Operator* valueOp)
    {
        const llvm::Type* type1 = valueOp->getOperand(1)->getType();
        const llvm::Type* type2 = valueOp->getOperand(2)->getType();
        
        if (!ti::isAtom(type1) || !ti::isAtom(type2))
        {
            throw NotImplementedException("Non-atomic select");
        }
        
        ir_node* predicate = retrieve(valueOp->getOperand(0));
        ir_node* node1     = retrieve(valueOp->getOperand(1));
        ir_node* node2     = retrieve(valueOp->getOperand(2));
        
        // Cast the operands to their base mode, make the predicate mode_b.
        predicate = ac::boolToB(valueOp->getOperand(0)->getType(), predicate);
        node1     = ac::atomToBase(type1, node1);
        node2     = ac::atomToBase(type2, node2);
        assert(ti::modeIsEqual(node1, node2));
        
        return new_Mux(predicate, node2, node1, get_irn_mode(node1));
    }
}
