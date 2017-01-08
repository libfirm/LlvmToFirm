#include "../Builders/NodeBuilder.hpp"

#include <cassert>
#include <climits>
#include <llvm/Constants.h>
#include <llvm/GlobalValue.h>
#include <llvm/DerivedTypes.h>
#include <libfirm/firm.h>
#include "../Builders/TypeBuilder.hpp"
#include "../Util/Logging.hpp"
#include "../Util/LlvmTools.hpp"
#include "../Util/TypeInfo.hpp"
#include "../Context.hpp"
#include "../Exceptions/NotSupportedException.hpp"
#include "../Exceptions/NotImplementedException.hpp"

namespace ltf
{
    /* ====================================================================== */
    /* =                        Primitive constants                         = */
    /* ====================================================================== */
    
    // [float]
    ir_node* NodeBuilder::buildFloat(const llvm::ConstantFP* constant)
    {
        log::debug << "Building float constant \"";
        constant->print(log::debug);
        log::debug << "\"" << log::end;
        
        if (!ti::isFloat(constant->getType()))
        {
            throw NotSupportedException("Non-float float constant");
        }
        
        const llvm::Type* constantType = constant->getType();
        ir_mode*          constantMode = ti::getBaseMode(constantType);
        assert((constantMode != 0) && "Unknown mode on constant");

        // Convert the value to firm and return a new constant.
        tarval* value = lt::getTarvalFromFloat(
            constant->getValueAPF(), constantMode
        );
        
        return new_Const(value);
    }
    
    // [int]
    ir_node* NodeBuilder::buildInteger(const llvm::ConstantInt* constant)
    {
        log::debug << "Building integer constant \"";
        constant->print(log::debug);
        log::debug << "\"" << log::end;
        
        if (!ti::isInt(constant->getType()))
        {
            throw NotSupportedException("Non-int int constant");
        }
        
        // Use the common tuple construction method for big ints.
        if (ti::isBigInt(constant->getType()))
        {
            log::debug << "Constructing big integer tuple" << log::end;
            return buildTupleConstant(constant);
        }
        
        // Handle bool as mode_b, to enable optimizations.
        if (ti::isBool(constant->getType()))
        {
            assert(constant->equalsInt(0) || constant->equalsInt(1));
            bool value = constant->equalsInt(1);
            return new_Const_long(mode_b, value ? 1 : 0);
        }

        ir_mode* constantMode = ti::getBaseMode(constant->getType());
        assert((constantMode != 0) && "Unknown mode on constant");

        // Convert the value to firm and return a new constant.
        tarval* value = lt::getTarvalFromInteger(
            constant->getValue(), constantMode
        );
        
        return new_Const(value);
    }
    
    /* ====================================================================== */
    /* =                         Pointer constants                          = */
    /* ====================================================================== */
    
    // [ptr]
    ir_node* NodeBuilder::buildNullPtr(const llvm::ConstantPointerNull* constant)
    {
        if (!ti::isPtr(constant->getType()))
        {
            throw NotSupportedException("Non-pointer pointer constant");
        }
        
        return new_Const_long(mode_P, 0);
    }
    
    // [ptr]
    ir_node* NodeBuilder::buildPointer(const llvm::GlobalValue* constant)
    {
        std::string mangledName = context.mangle(constant);
        log::debug << "Building pointer to \"" << mangledName << "\"" << log::end;
        
        if (!ti::isPtr(constant->getType()))
        {
            throw NotSupportedException("Non-pointer pointer constant");
        }
        
        // Create an appropriate symbolic constant.
        symconst_symbol symbol;
        symbol.entity_p = context.retrieveEntity(constant);
        assert((symbol.entity_p != 0) && "Pointer to unknown entity");
        
        return new_SymConst(mode_P, symbol, symconst_addr_ent);
    }
    
    /* ====================================================================== */
    /* =                          Unknown constant                          = */
    /* ====================================================================== */
    
    ir_node* NodeBuilder::buildUndef(const llvm::UndefValue* constant)
    {
        if (ti::isTuple(constant->getType()))
        {
            return buildTupleUndef(constant);
        }
        else if (!ti::isAtom(constant->getType()))
        {
            throw NotSupportedException("Non-atomic and non-tuple undef");
        }

        ir_mode* constantMode = ti::getBaseMode(constant->getType());
        assert((constantMode != 0) && "Non-atomic undef");
        
        return new_Unknown(constantMode);
    }
    
    /* ====================================================================== */
    /* =                        Aggregate Constants                         = */
    /* ====================================================================== */
    
    // The common tuple construction method will do.
    
    ir_node* NodeBuilder::buildArray(const llvm::ConstantArray* constant)
    {
        log::debug << "Constructing array tuple" << log::end;
        return buildTupleConstant(constant);
    }
    
    ir_node* NodeBuilder::buildStruct(const llvm::ConstantStruct* constant)
    {
        log::debug << "Constructing structure tuple" << log::end;
        return buildTupleConstant(constant);
    }
}
