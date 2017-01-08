#ifndef LTF_TD_POINTER_HPP_
#define LTF_TD_POINTER_HPP_

#include <boost/shared_ptr.hpp>
#include <boost/scoped_ptr.hpp>

namespace llvm
{
    class Module;
}

namespace ltf
{
    class Context;
    class BlockBuilder;
    class EntityBuilder;
    class FrameBuilder;
    class GraphBuilder;
    class NodeBuilder;
    class TypeBuilder;
    class BlockScope;
    class GraphScope;
    class Parser;
    class Optimizer;
    class Backend;
    
    namespace log
    {
        class Logger;
    }
    
    // Most common shared pointers.
    typedef boost::shared_ptr<llvm::Module>  ModuleSPtr;
    typedef boost::shared_ptr<Context>       ContextSPtr;
    typedef boost::shared_ptr<BlockBuilder>  BlockBuilderSPtr;
    typedef boost::shared_ptr<EntityBuilder> EntityBuilderSPtr;
    typedef boost::shared_ptr<FrameBuilder>  FrameBuilderSPtr;
    typedef boost::shared_ptr<GraphBuilder>  GraphBuilderSPtr;
    typedef boost::shared_ptr<NodeBuilder>   NodeBuilderSPtr;
    typedef boost::shared_ptr<TypeBuilder>   TypeBuilderSPtr;
    typedef boost::shared_ptr<log::Logger>   LoggerSPtr;
    typedef boost::shared_ptr<Parser>        ParserSPtr;
    typedef boost::shared_ptr<Optimizer>     OptimizerSPtr;
    typedef boost::shared_ptr<Backend>       BackendSPtr;
    
    // Can be quite handy, when scopes need to change.
    typedef boost::scoped_ptr<BlockScope>    BlockScopeScpPtr;
    typedef boost::scoped_ptr<GraphScope>    GraphScopeScpPtr;
}

#endif /* LTF_TD_POINTER_HPP_ */
