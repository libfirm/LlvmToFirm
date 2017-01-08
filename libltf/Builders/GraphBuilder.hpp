#ifndef LTF_BLD_GRAPH_BUILDER_HPP_
#define LTF_BLD_GRAPH_BUILDER_HPP_

#include <vector>
#include <libfirm/firm_types.h>
#include "Builder.hpp"
#include "../Typedef/Pointer.hpp"
#include "../Facade/Converter.hpp"

namespace llvm
{
    class Function;
    class PHINode;
}

namespace ltf
{
    class Context;
    class BlockBuilder;
    class GraphInfo;
    
    class GraphBuilder : public Builder<const llvm::Function*, ir_graph*> 
    {
    public:
        GraphBuilder(Context& context)
            : context(context),
              fpModel(FPModel::Precise)
        { }
        
        // Set the floating point model to use for newly constructed graphs.
        void setFPModel(FPModelE fpModel)
        {
            this->fpModel = fpModel;
        }
        
    protected:
        ir_graph* doBuild(const llvm::Function* func, bool& doCache);
        
    private:
        Context& context;
        FPModelE fpModel;
    };
}

#endif /* LTF_BLD_GRAPH_BUILDER_HPP_ */
