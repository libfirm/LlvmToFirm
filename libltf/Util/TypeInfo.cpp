#include "TypeInfo.hpp"

#include <llvm/Type.h>
#include <llvm/Constant.h>
#include <llvm/Constants.h>
#include <llvm/ADT/APInt.h>
#include <llvm/DerivedTypes.h>
#include <llvm/Support/Casting.h>
#include <libfirm/firm.h>
#include "../Typedef/Vector.hpp"
using llvm::isa;
using llvm::cast;

namespace ltf
{
    namespace ti
    {
        bool isBool(const llvm::Type* type)
        {
            // An integer with width 1 is a bool.
            if (!isInt(type)) return false;
            return (cast<llvm::IntegerType>(type)->getBitWidth() == 1);
        }
        
        bool isInt(const llvm::Type* type)
        {
            return type->isInteger();
        }
        
        bool isModInt(const llvm::Type* type)
        {
            if (!isInt(type)) return false;
            unsigned int width = getWidth(type);
            
            if (width > 64)
            {
                // Above 64 bit, check if it is a multiple.
                return (width % 32) != 0;
            }
            
            // Check against the native type widths.
            return (width != 8)  && (width != 16) &&
                   (width != 32) && (width != 64);
        }
        
        bool isBigInt(const llvm::Type* type)
        {
            // Anything above 64 bit is considered big.
            if (!isInt(type)) return false;
            return getWidth(type) > 64;
        }
        
        bool isIntAtom(const llvm::Type* type)
        {
            return isInt(type) && isAtom(type);
        }
        
        bool isFloat(const llvm::Type* type)
        {
            return type->isFloatingPoint();
        }
        
        bool isPtr(const llvm::Type* type)
        {
            return isa<llvm::PointerType>(type);
        }
        
        bool isAtom(const llvm::Type* type)
        {
            // As isNative(), but includes modulo types.
            if (isInt(type))
            {
                return !isBigInt(type);
            }
            
            return isFloat(type) || isPtr(type);
        }
        
        bool isNative(const llvm::Type* type)
        {
            if (isInt(type))
            {
                // Ints that are neither modulo, nor big are native.
                // Note that bool is not considered native.
                return !isModInt(type) && !isBigInt(type);
            }
            
            // Floats and pointers remain.
            return isFloat(type) || isPtr(type);
        }
        
        bool isAggregate(const llvm::Type* type)
        {
            // Aggregate types are the same as in firm.
            // Big int is no aggregate!
            return type->isAggregateType();
        }
        
        bool isTuple(const llvm::Type* type)
        {
            // Aggregates and big ints are passed as tuples.
            return isAggregate(type) || isBigInt(type);
        }
        
        unsigned int getWidth(const llvm::Type* type)
        {
            if (isInt(type))
            {
                return cast<llvm::IntegerType>(type)->getBitWidth();
            }
            
            return getBaseWidth(type);
        }
        
        unsigned int getBaseWidth(const llvm::Type* type)
        {
            return get_mode_size_bits(getBaseMode(type));
        }
        
        ir_mode* getBaseMode(const llvm::Type* type)
        {
            // Aggregates and big int.
            if (isTuple(type))
            {
                return mode_T;
            }
            else if (isPtr(type))
            {
                return mode_P;
            }
            else if (isInt(type))
            {
                unsigned int width = getWidth(type);
                
                // Return the smallest mode that supports the width.
                if      (width <= 8)  return mode_Bs;
                else if (width <= 16) return mode_Hs;
                else if (width <= 32) return mode_Is;
                else if (width <= 64) return mode_Ls;
                
                assert(0 && "Unexpected integer type");
            }
            else if (isFloat(type))
            {
                // Select the appropriate firm mode.
                switch (type->getTypeID())
                {
                case llvm::Type::FloatTyID:    return mode_F;
                case llvm::Type::DoubleTyID:   return mode_D;
                case llvm::Type::X86_FP80TyID: return mode_E;
                }
                
                assert(0 && "Unexpected float type");
            }
            
            assert(0 && "Unexpected type");
        }
        
        bool modeIsEqual(ir_node* node1, ir_node* node2)
        {
            return get_irn_mode(node1) == get_irn_mode(node2);
        }
        
        ir_mode* getSignedMode(ir_mode* mode)
        {
            if (mode_is_signed(mode)) return mode;
            return find_signed_mode(mode);
        }
        
        ir_mode* getUnsignedMode(ir_mode* mode)
        {
            if (!mode_is_signed(mode)) return mode;
            return find_unsigned_mode(mode);
        }
       
        unsigned int getTupleSize(const llvm::Type* type)
        {
            assert(isTuple(type) && "Non-tuple type given");
            
            // Return the number of entries for the different tuple types.
            if (isa<llvm::ArrayType>(type))
            {
                return cast<llvm::ArrayType>(type)->getNumElements();
            }
            else if (isa<llvm::StructType>(type))
            {
                return cast<llvm::StructType>(type)->getNumElements();
            }
            else if (isa<llvm::IntegerType>(type))
            {
                return (cast<llvm::IntegerType>(type)->getBitWidth() + 31) / 32;
            }
            
            assert(0 && "Invalid tuple type");
            return 0;
        }
        
        const llvm::Type* getTupleType(const llvm::Type* type, unsigned int index)
        {
            assert(isTuple(type) && "Non-tuple type given");
            
            if (isa<llvm::ArrayType>(type))
            {
                // All entries have the same type.
                return cast<llvm::ArrayType>(type)->getElementType();
            }
            else if (isa<llvm::StructType>(type))
            {
                // Retrieve the type of the appropriate entry.
                return cast<llvm::StructType>(type)->getElementType(index);
            }
            else if (isa<llvm::IntegerType>(type))
            {
                // A collection of words.
                return llvm::IntegerType::get(llvm::getGlobalContext(), 32);
            }
            
            assert(0 && "Invalid tuple type");
            return 0;
        }
        
        const llvm::Constant* getTupleEntry(const llvm::Constant* constant, unsigned int index)
        {
            assert(isTuple(constant->getType()) && "Non-tuple constant given");
            
            if (isa<llvm::ConstantArray>(constant) ||
                isa<llvm::ConstantStruct>(constant))
            {
                return constant->getOperand(index);
            }
            else if (isa<llvm::ConstantInt>(constant))
            {
                const llvm::ConstantInt* valueConstant =
                    cast<llvm::ConstantInt>(constant);
                
                // XXX: little/big endian?
                const uint32_t* rawData = reinterpret_cast<const uint32_t*>(
                    valueConstant->getValue().getRawData()
                );
                
                // Create an integer constant for the appropriate word.
                return llvm::ConstantInt::get(
                    getTupleType(constant->getType(), 0), rawData[index]
                );
            }
            
            assert(0 && "Invalid tuple type");
            return 0;
        }
        
        const llvm::StructType* getBigIntStruct(const llvm::Type* type)
        {
            assert(ti::isBigInt(type));
            
            // Get arity and base type.
            const llvm::Type* baseType = ti::getTupleType(type, 0);
            unsigned int      arity    = ti::getTupleSize(type);
            
            // Repeat the base type in a packed struct.
            TypeVect types(arity, baseType);
            return llvm::StructType::get(llvm::getGlobalContext(), types, true);
        }
    }
}
