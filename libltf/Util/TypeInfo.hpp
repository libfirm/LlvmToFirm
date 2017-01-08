#ifndef LTF_UTIL_TYPE_INFO_HPP_
#define LTF_UTIL_TYPE_INFO_HPP_

#include <libfirm/firm_types.h>

namespace llvm
{
    class Type;
    class StructType;
    class Constant;
}

namespace ltf
{
    namespace ti
    {
        // Easy type checks, regarding type representation in firm. Some of
        // these functions merely call LLVM methods, but they are still here
        // for symmetry reasons.
        
        // Basic value types.
        bool isInt   (const llvm::Type* type);
        bool isFloat (const llvm::Type* type);
        bool isPtr   (const llvm::Type* type);
        
        // Native and composed types.
        bool isAtom      (const llvm::Type* type); // Has an atomic mode.
        bool isNative    (const llvm::Type* type); // Is natively supported.
        bool isAggregate (const llvm::Type* type); // Is an LLVM aggregate.
        bool isTuple     (const llvm::Type* type); // Is handled as tuple.
        
        // Different integer types.
        bool isBool    (const llvm::Type* type);
        bool isModInt  (const llvm::Type* type);
        bool isBigInt  (const llvm::Type* type);
        bool isIntAtom (const llvm::Type* type);
        
        // LLVM types have a base mode in firm, which is the mode that can be
        // used for storage and most other operations. The base mode of modulo
        // types is the next-biggest mode, the base mode of big ints is the
        // mode of the tuples contents. The base mode for i1 is Bs.
        unsigned int getWidth     (const llvm::Type* type);
        unsigned int getBaseWidth (const llvm::Type* type);
        ir_mode*     getBaseMode  (const llvm::Type* type);

        // Check if both nodes have equal mode.
        bool modeIsEqual(ir_node* node1, ir_node* node2);

        // Like firms find_signed_mode, but returns a mode that already has
        // the correct signedness.
        ir_mode* getSignedMode   (ir_mode* mode);
        ir_mode* getUnsignedMode (ir_mode* mode);
        
        // Uniformly access tuple entries and types.
        unsigned int          getTupleSize  (const llvm::Type* type);
        const llvm::Type*     getTupleType  (const llvm::Type* type,
                                             unsigned int index);
        const llvm::Constant* getTupleEntry (const llvm::Constant* constant,
                                             unsigned int index);
        
        // Construct a packed structure for a big integer.
        const llvm::StructType* getBigIntStruct(const llvm::Type* type);
    }
}

#endif /* LTF_UTIL_TYPE_INFO_HPP_ */
