#ifndef LTF_RAII_GRAPH_SCOPE_HPP_
#define LTF_RAII_GRAPH_SCOPE_HPP_

#include <boost/utility.hpp>
#include <libfirm/firm_types.h>

namespace ltf
{
    // Setup a new current graph and restore it when leaving scope.
    class GraphScope : boost::noncopyable
    {
    private:
        ir_graph* oldGraph;
        
    public:
        GraphScope(ir_graph* graph);
        ~GraphScope();
    };
}

#endif /* LTF_RAII_GRAPH_SCOPE_HPP_ */
