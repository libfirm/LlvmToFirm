#ifndef LTF_OPT_BASE_PASSES_HPP_
#define LTF_OPT_BASE_PASSES_HPP_

#include <string>
#include <libfirm/firm_types.h>

namespace ltf
{
    namespace opt
    {
        // Basic optimization pass.
        struct Pass
        {
        protected:
            std::string name;
            bool isEnabled;
            
        public:
            Pass(const std::string& name);
            const std::string& getName();
            
            void setIsEnabled(bool isEnabled);
            bool getIsEnabled();
        };
        
        struct ProgramPass : public Pass
        {
        public:
            ProgramPass(const std::string& name) : Pass(name) { }
            void run();
            
        protected:
            virtual void doRun() = 0;
        };
        
        struct GraphPass : public Pass
        {
        public:
            GraphPass(const std::string& name) : Pass(name) { }
            void run(ir_graph* graph);
        
        protected:
            virtual void doRun(ir_graph* graph) = 0;
        };
    }
}

#endif /* LTF_OPT_BASE_PASSES_HPP_ */
