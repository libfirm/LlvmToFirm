#ifndef LTF_BLD_TYPE_BUILDER_HPP_
#define LTF_BLD_TYPE_BUILDER_HPP_

#include <utility>
#include <string>
#include <boost/shared_ptr.hpp>
#include <libfirm/firm_types.h>
#include "Builder.hpp"
#include "TypeMetakey.hpp"

namespace llvm
{
    class Type;
    class ArrayType;
    class PointerType;
    class IntegerType;
    class FunctionType;
    class StructType;
    class OpaqueType;
    class TargetData;
}

namespace ltf
{
    class Context;

    class TypeBuilder : public Builder<const llvm::Type*, ir_type*, TypeMetakey>
    {
    public:
        TypeBuilder(Context& context);

        // Specialized function lookup.
        ir_type* retrieveFunction(
            const llvm::FunctionType* type,
            boost::shared_ptr<FunctionTypeMetakey> metadata
        );
        
        ir_type* lookupFunction(
            const llvm::FunctionType* type,
            boost::shared_ptr<FunctionTypeMetakey> metadata
        );
        
    protected:
        ir_type* doBuild(const llvm::Type* type, bool& doCache);
        
    private:
        static const unsigned int maxTypeNameLength = 50;
        
        Context& context;
        unsigned int uniqueCounter;

        // Actual builder methods.
        ir_type* buildFloat   (const llvm::Type*        type);
        ir_type* buildArray   (const llvm::ArrayType*   type);
        ir_type* buildStruct  (const llvm::StructType*  type, bool& doCache,
                               const std::string& name = "");
        ir_type* buildPointer (const llvm::PointerType* type, bool& doCache);
        ir_type* buildOpaque  (const llvm::OpaqueType*  type);        
        ir_type* buildInteger (const llvm::IntegerType* integerType);
        
        ir_type* buildFunction(
            const llvm::FunctionType* type,
            boost::shared_ptr<FunctionTypeMetakey> metadata,
            bool& doCache
        );

        ident* createIdentifier(const std::string& name);
        ident* createIdentifier(const std::string& prefix, int counter);
        
        ident* createIdentifier(
            const llvm::Type* type, const std::string& suffix = ""
        );
    };
}

#endif /* LTF_BLD_TYPE_BUILDER_HPP_ */
