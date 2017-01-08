#ifndef LTF_CONTEXT_HPP_
#define LTF_CONTEXT_HPP_

#include <libfirm/firm_types.h>
#include "Typedef/Pointer.hpp"

namespace llvm
{
    class Type;
    class Constant;
    class GlobalValue;
    class Function;
    class Instruction;
    class BasicBlock;
    class Argument;
    class Module;
    class Mangler;
    class TargetData;
}

namespace ltf
{
    class TypeBuilder;
    class BlockBuilder;
    class GraphBuilder;
    class EntityBuilder;
    
    class Context
    {
    public:
        Context(ModuleSPtr module);
        
        ////////////////////
        // Getter methods //
        ////////////////////
        
        ModuleSPtr getModule()
        {
            return module;
        }
        
        boost::shared_ptr<llvm::TargetData> getTargetData()
        {
            return targetData;
        }
       
        TypeBuilderSPtr getTypeBuilder()
        {
            return typeBuilder;
        }

        GraphBuilderSPtr getGraphBuilder()
        {
            return graphBuilder;
        }
        
        EntityBuilderSPtr getEntityBuilder()
        {
            return entityBuilder;
        }

        /////////////////////////
        // Convenience methods //
        /////////////////////////
        
        std::string mangle(const llvm::GlobalValue* value);

        ir_type*   retrieveType   (const llvm::Type*        type);
        ir_graph*  retrieveGraph  (const llvm::Function*    function);
        ir_entity* retrieveEntity (const llvm::GlobalValue* value);
        
    private:
        boost::shared_ptr<llvm::Mangler>    mangler;
        boost::shared_ptr<llvm::TargetData> targetData;
        
        ModuleSPtr        module;
        TypeBuilderSPtr   typeBuilder;
        GraphBuilderSPtr  graphBuilder;
        EntityBuilderSPtr entityBuilder;
    };
}

#endif /* LTF_CONTEXT_HPP_ */
