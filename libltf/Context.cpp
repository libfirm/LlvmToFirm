#include "Context.hpp"

#include <llvm/Support/Mangler.h>
#include <llvm/Target/TargetData.h>
#include "Builders/NodeBuilder.hpp"
#include "Builders/TypeBuilder.hpp"
#include "Builders/BlockBuilder.hpp"
#include "Builders/GraphBuilder.hpp"
#include "Builders/EntityBuilder.hpp"
using namespace boost;

namespace ltf
{
    Context::Context(ModuleSPtr module)
        : module        (module),
          typeBuilder   (new TypeBuilder(*this)),
          graphBuilder  (new GraphBuilder(*this)),
          entityBuilder (new EntityBuilder(*this))
    {
        assert(module.get() != 0);
                
        // Initialize the mangler to use.
        mangler = shared_ptr<llvm::Mangler>(
            new llvm::Mangler(*module.get())
        );
        
        // Target data derived from the module description.
        targetData = shared_ptr<llvm::TargetData>(
            new llvm::TargetData(module.get())
        );
    }
    
    std::string Context::mangle(const llvm::GlobalValue* value)
    {
        return mangler->getMangledName(value);
    }

    ir_type* Context::retrieveType(const llvm::Type* type)
    {
        return typeBuilder->retrieve(type);
    }

    ir_graph* Context::retrieveGraph(const llvm::Function* function)
    {
        return graphBuilder->retrieve(function);
    }
    
    ir_entity* Context::retrieveEntity(const llvm::GlobalValue* value)
    {
        return entityBuilder->retrieve(value);
    }
}
