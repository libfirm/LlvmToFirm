#ifndef LTF_BLD_ENTITY_BUILDER_HPP_
#define LTF_BLD_ENTITY_BUILDER_HPP_

#include <boost/shared_ptr.hpp>
#include <libfirm/firm_types.h>
#include "Builder.hpp"

namespace llvm
{
    class Mangler;
    class GlobalValue;
    class Function;
    class Constant;
    class GlobalVariable;
}

namespace ltf
{
    class Context;
    class NodeBuilder;
    
    class EntityBuilder : public Builder<const llvm::GlobalValue*, ir_entity*> 
    {
    public:
        EntityBuilder(Context& context);
        
    protected:
        ir_entity* doBuild(const llvm::GlobalValue* value, bool& doCache);
        
    private:
        Context& context;
        boost::shared_ptr<NodeBuilder> nodeBuilder;
        
        ir_entity* buildFunction(const llvm::Function*       function);
        ir_entity* buildVariable(const llvm::GlobalVariable* variable, bool& doCache);
        ir_entity* buildCtorDtor(const llvm::GlobalVariable* variable);
        
        // Create initializers. Atomic values directly take nodes.
        ir_initializer_t* buildInitializer       (const llvm::Constant* constant);
        ir_node*          buildAtomicInitializer (const llvm::Constant* constant);
        
        void applyLinkage(const llvm::GlobalValue* value, ir_entity* entity);
    };
}

#endif /* LTF_BLD_ENTITY_BUILDER_HPP_ */
