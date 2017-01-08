#include "GraphScope.hpp"

#include <cassert>
#include <libfirm/firm.h>
#include "../Util/Logging.hpp"

namespace ltf
{
    GraphScope::GraphScope(ir_graph* graph)
        : oldGraph(0)
    {
        assert(graph != 0);
        ir_graph* currentGraph = get_current_ir_graph();
        
        if (graph != currentGraph)
        {
            log::debug << "Switching to graph " << get_irg_idx(graph) << log::end;
            set_current_ir_graph(graph);
            oldGraph = currentGraph;
        }
    }
        
    GraphScope::~GraphScope()
    {
        if (oldGraph != 0)
        {
            log::debug << "Restoring graph " << get_irg_idx(oldGraph) << log::end;
            set_current_ir_graph(oldGraph);
        }
    }
}
