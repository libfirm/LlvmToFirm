#ifndef LTF_OPT_OPTIMIZATION_PASSES_HPP_
#define LTF_OPT_OPTIMIZATION_PASSES_HPP_

#include <string>
#include <cstring>
#include <libfirm/firm.h>
#include "BasePasses.hpp"

namespace ltf
{
    namespace opt
    {
        // Combined CCE, UCE and GVN.
        struct ComboPass : public GraphPass
        {
            static std::string getName() { return "combo"; }
            ComboPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { combo(graph); }
        };
        
        // Optimization of control-flow.
        struct ControlFlowPass : public GraphPass
        {
            static std::string getName() { return "control-flow"; }
            ControlFlowPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { optimize_cf(graph); }
        };
        
        // Local graph optimizations.
        struct LocalOptPass : public GraphPass
        {
            static std::string getName() { return "local"; }
            LocalOptPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { optimize_graph_df(graph); }
        };
        
        // Normalisation to one return node.
        struct OneReturnPass : public GraphPass
        {
            static std::string getName() { return "one-return"; }
            OneReturnPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { normalize_one_return(graph); }
        };
        
        // Scalar replacement optimizations.
        struct ScalarReplacePass : public GraphPass
        {
            static std::string getName() { return "scalar-replace"; }
            ScalarReplacePass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { scalar_replacement_opt(graph); }
        };
        
        // Reassociation optimization.
        struct ReassociationPass : public GraphPass
        {
            static std::string getName() { return "reassociation"; }
            ReassociationPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { optimize_reassociation(graph); }
        };
        
        // Global common subexpression elimination.
        struct GlobalCSEPass : public GraphPass
        {
            static std::string getName() { return "gcse"; }
            GlobalCSEPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph)
            {
                // Enable CSE, optimize the graph, re-place nodes.
                set_opt_global_cse(true);
                optimize_graph_df(graph);
                place_code(graph);
                set_opt_global_cse(false);
            }
        };
        
        // Place code, pin floating nodes.
        struct CodePlacementPass : public GraphPass
        {
            static std::string getName() { return "place"; }
            CodePlacementPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { place_code(graph); }
        };
        
        // Add confirm nodes, providing information for optimizations.
        struct AddConfirmsPass : public GraphPass
        {
            static std::string getName() { return "confirm"; }
            AddConfirmsPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { construct_confirms(graph); }
        };
        
        // Remove confirm nodes again.
        struct RemoveConfirmsPass : public GraphPass
        {
            static std::string getName() { return "remove-confirms"; }
            RemoveConfirmsPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { remove_confirms(graph); }
        };
        
        // Optimize load and store nodes.
        struct LoadStoreOptPass : public GraphPass
        {
            static std::string getName() { return "opt-load-store"; }
            LoadStoreOptPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { optimize_load_store(graph); }
        };
        
        // Try to parallelize memory access.
        struct ParallelizeMemoryPass : public GraphPass
        {
            static std::string getName() { return "parallelize-mem"; }
            ParallelizeMemoryPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { opt_parallelize_mem(graph); }
        };
        
        // Try to reduce conv nodes.
        struct DeconvPass : public GraphPass
        {
            static std::string getName() { return "deconv"; }
            DeconvPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { conv_opt(graph); }
        };
        
        // Path-sensitive jumpthreading.
        struct JumpthreadingPass : public GraphPass
        {
            static std::string getName() { return "thread-jumps"; }
            JumpthreadingPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { opt_jumpthreading(graph); }
        };
        
        // Gloval value numbering and partial redundancy elimination.
        struct GvnPrePass : public GraphPass
        {
            static std::string getName() { return "gvn-pre"; }
            GvnPrePass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { do_gvn_pre(graph); }
        };
        
        // If-conversion optimization.
        struct IfConversionPass : public GraphPass
        {
        private:
            bool isInitialized;
            ir_settings_if_conv_t settings;
            
        public:
            static std::string getName() { return "if-conversion"; }
            
            IfConversionPass()
                : GraphPass(getName()), isInitialized(false)
            { }
            
            void doRun(ir_graph* graph)
            {
                // If settings were not set before, get them from the backend.
                if (!isInitialized)
                {
                    setSettings(be_get_backend_param()->if_conv_info);
                }
                
                opt_if_conv(graph, &settings);
            }
            
            void setSettings(const ir_settings_if_conv_t* settings)
            {
                if (settings == 0)
                {
                    isInitialized = false;
                    return;
                }
                
                memcpy(&this->settings, settings, sizeof(ir_settings_if_conv_t));
                isInitialized = true;
            }
        };
        
        // Boolean expression simplification.
        struct BoolOptPass : public GraphPass
        {
            static std::string getName() { return "bool"; }
            BoolOptPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { opt_bool(graph); }
        };

        // Combines congruent blocks into one.
        struct BlockShapingPass : public GraphPass
        {
            static std::string getName() { return "shape-blocks"; }
            BlockShapingPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { shape_blocks(graph); }
        };
        
        // Induction variable strength reduction.
        struct IVOptPass : public GraphPass
        {
            static std::string getName() { return "ivopts"; }
            IVOptPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph)
            {
                // Settings taken from cparser.
                opt_osr(graph,
                    osr_flag_default |
                    osr_flag_keep_reg_pressure |
                    osr_flag_ignore_x86_shift
                );
            }
        };
        
        // Remove phi cycles.
        struct RemovePhiCyclesPass : public GraphPass
        {
            static std::string getName() { return "remove-phi-cycles"; }
            RemovePhiCyclesPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { remove_phi_cycles(graph); }
        };
        
        // Remove dead nodes.
        struct RemoveDeadNodesPass : public GraphPass
        {
            static std::string getName() { return "dead"; }
            RemoveDeadNodesPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { dead_node_elimination(graph); }
        };
        
        // Convert loops into foot-controlled loops.
        struct InvertLoopsPass : public GraphPass
        {
            static std::string getName() { return "invert-loops"; }
            InvertLoopsPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { do_loop_inversion(graph); }
        };
        
        // Perform loop peeling.
        struct PeelLoopsPass : public GraphPass
        {
            static std::string getName() { return "peel-loops"; }
            PeelLoopsPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph) { do_loop_peeling(graph); }
        };
        
        // Remove unused functions from the program.
        struct RemoveUnusedPass : public ProgramPass
        {
            static std::string getName() { return "remove-unused"; }
            RemoveUnusedPass() : ProgramPass(getName()) { }
            
            void doRun()
            {
                garbage_collect_entities();
            }
        };
        
        // Tail recursion optimization.
        struct TailRecursionPass : public ProgramPass
        {
            static std::string getName() { return "opt-tail-rec"; }
            TailRecursionPass() : ProgramPass(getName()) { }
            
            void doRun() { opt_tail_recursion(); }
        };
        
        // Optimize const function calls.
        struct OptimizeCallsPass : public ProgramPass
        {
            static std::string getName() { return "opt-func-call"; }
            OptimizeCallsPass() : ProgramPass(getName()) { }
            
            void doRun()
            {
                // No need to enforce a run. We never set irg_const_function.
                optimize_funccalls(false, 0);
            }
        };
        
        // Inline function graphs.
        struct InlinePass : public ProgramPass
        {
        private:
            unsigned maxSize;
            unsigned threshold;
            opt_ptr  callback;
            
        public:
            static std::string getName() { return "inline"; }
            
            InlinePass()
                : ProgramPass(getName()), maxSize(750), threshold(0), callback(0)
            { }
            
            void doRun()
            {
                inline_functions(maxSize, threshold, callback);
            }
            
            // Getter/setter for settings.
            void setMaxSize(unsigned maxSize)
            {
                this->maxSize = maxSize;
            }
            
            void setThreshold(unsigned threshold)
            {
                this->threshold = threshold;
            }
            
            void setCallback(opt_ptr callback)
            {
                this->callback = callback;
            }
        };
        
        // Clone functions using constant parameters.
        struct CloningPass : public ProgramPass
        {
        private:
            float threshold;
            
        public:
            static std::string getName() { return "opt-proc-clone"; }
            
            CloningPass()
                : ProgramPass(getName()), threshold(DEFAULT_CLONE_THRESHOLD)
            { }
            
            void doRun()
            {
                proc_cloning(threshold);
            }
            
            void setThreshold(float threshold)
            {
                this->threshold = threshold;
            }
        };
        
        // Lower high-level constructs like SymConst.
        struct LowerPass : public GraphPass
        {
            static std::string getName() { return "lower"; }
            LowerPass() : GraphPass(getName()) { }
            
            void doRun(ir_graph* graph)
            {
                // Bitfields are already handled by the more generic support
                // for LLVMs arbitrary bit width integers.
                lower_highlevel_graph(graph, false);
            }
        };
        
        // Lower switch statements with too many cases.
        struct LowerSwitchPass : public GraphPass
        {
        private:
            unsigned spareSize;
            
        public:
            static std::string getName() { return "lower-switch"; }
            
            LowerSwitchPass()
                : GraphPass(getName()), spareSize(128)
            { }
                        
            void doRun(ir_graph* graph)
            {
                lower_switch(graph, spareSize);
            }
            
            void setSpareSize(unsigned spareSize)
            {
                this->spareSize = spareSize;
            }
        };
        
        // Lower mux nodes to control flow.
        struct LowerMuxPass : public GraphPass
        {
        private:
            lower_mux_callback* callback;
            
        public:
            static std::string getName() { return "lower-mux"; }
            
            LowerMuxPass()
                : GraphPass(getName()), callback(0)
            { }
            
            void doRun(ir_graph* graph)
            {
                lower_mux(graph, callback);
            }
            
            void setCallback(lower_mux_callback* callback)
            {
                this->callback = callback;
            }
        };
        
        // Lower high-level constructs on the const graph.
        struct LowerConstPass : public ProgramPass
        {
            static std::string getName() { return "lower-const"; }
            LowerConstPass() : ProgramPass(getName()) { }
            
            void doRun() { lower_const_code(); }
        };
        
        // Lower double word nodes.
        struct LowerDwordPass : public ProgramPass
        {
        private:
            bool isInitialized;
            lwrdw_param_t settings;
            
        public:
            static std::string getName() { return "lower-dw"; }
            
            LowerDwordPass()
                : ProgramPass(getName()), isInitialized(false)
            { }
            
            void doRun()
            {
                // If settings were not set before, use defaults.
                if (!isInitialized)
                {
                    const backend_params* backendParams = be_get_backend_param();
                    
                    settings.enable           = true;
                    settings.high_signed      = mode_Ls;
                    settings.high_unsigned    = mode_Lu;
                    settings.low_signed       = mode_Is;
                    settings.low_unsigned     = mode_Iu;
                    settings.little_endian    = true;
                    settings.create_intrinsic = backendParams->arch_create_intrinsic_fkt;
                    settings.ctx              = backendParams->create_intrinsic_ctx;
                    
                    isInitialized = true;
                }
                
                lower_dw_ops(&settings);
            }
            
            void setSettings(const lwrdw_param_t* settings)
            {
                if (settings == 0)
                {
                    isInitialized = false;
                    return;
                }
                
                memcpy(&this->settings, settings, sizeof(lwrdw_param_t));
                isInitialized = true;
            }
        };
    }
}

#endif /* LTF_OPT_OPTIMIZATION_PASSES_HPP_ */
