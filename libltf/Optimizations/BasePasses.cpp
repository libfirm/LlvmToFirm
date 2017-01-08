#include "BasePasses.hpp"

#include <cassert>
#include <libfirm/firm.h>
#include "../Util/Logging.hpp"

namespace ltf
{
    namespace opt
    {
        Pass::Pass(const std::string& name)
            : isEnabled(true)
        {
            this->name = name;
        }
        
        const std::string& Pass::getName()
        {
            return name;
        }
        
        // Enable/disable the pass.
        void Pass::setIsEnabled(bool isEnabled)
        {
            this->isEnabled = isEnabled;
        }
        
        bool Pass::getIsEnabled()
        {
            return isEnabled;
        }
        
        void ProgramPass::run()
        {
            if (!isEnabled) return;
            
            log::debug << "Running pass " << name << log::end;
            doRun();
        }
        
        void GraphPass::run(ir_graph* graph)
        {
            assert(graph != 0);
            if (!isEnabled) return;
            
            ir_entity*  funcEntity = get_irg_entity(graph);
            ident*      funcIdent  = get_entity_ident(funcEntity);
            const char* funcName   = get_id_str(funcIdent);
            
            log::debug << "Running pass " << funcName <<
                " -> " << name << log::end;
            doRun(graph);
        }
    }
}
