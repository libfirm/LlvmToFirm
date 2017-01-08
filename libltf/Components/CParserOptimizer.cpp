#include "CParserOptimizer.hpp"

#include <stdexcept>
#include <libfirm/firm.h>
#include "../Config.hpp"
#include "../Util/Logging.hpp"
#ifdef LOWER_CMPF_PROJB_CONV
#include "../RAII/UnoptimizedScope.hpp"
#endif
#include "../Optimizations/OptimizationPasses.hpp"
using boost::logic::tribool;
using boost::logic::indeterminate;

namespace ltf
{
    namespace
    {
#if defined(LOWER_CMPF_PROJB_MUX) || defined(LOWER_CMPF_PROJB_CONV)
        bool isCmpFProjB(ir_node* node)
        {
            // Is is a projb?
            if (!is_Proj(node)) return false;
            if (get_irn_mode(node) != mode_b) return false;
            
            // With a cmpf as predecessor?
            ir_node* predNode = get_Proj_pred(node);
            if (!is_Cmp(predNode)) return false;
            
            // Consider the mux as float, when either operand is a float.
            ir_node* leftNode  = get_Cmp_left(predNode);
            ir_node* rightNode = get_Cmp_right(predNode);
            
            return mode_is_float(get_irn_mode(leftNode)) ||
                   mode_is_float(get_irn_mode(rightNode));
        }
#endif
        
#ifdef LOWER_CMPF_PROJB_CONV
        void replaceCmpFConvB(ir_node* node, void* context)
        {
            if (!is_Conv(node)) return;
            
            // Find a predecessor with a projb that points to a fcmp.
            for (int i = 0; i < get_irn_arity(node); i++)
            {
                ir_node* projNode = get_irn_n(node, i);
                if (!isCmpFProjB(projNode)) continue;

                // Replace the conv node.
                ir_node* block     = get_nodes_block(node);
                ir_mode* mode      = get_irn_mode(node);
                ir_node* falseNode = new_Const_long(mode, 0);
                ir_node* trueNode  = new_Const_long(mode, 1);
                ir_node* muxNode   = new_r_Mux(
                    block, projNode, falseNode, trueNode, mode
                );
                
                exchange(node, muxNode);
                break;
            }
        }
        
        void replaceCmpFConvB(ir_graph* graph)
        {
            UnoptimizedScope scope;
            irg_walk_graph(graph, 0, replaceCmpFConvB, 0);
        }
#endif
        
        int isUnsupportedMux(ir_node* node)
        {
            if (!is_Mux(node)) return false;
            
#ifdef LOWER_ALL_MUX
            return true;
#else
#ifdef LOWER_CMPF_PROJB_MUX
            // Test whether the sel node is a float cmp and lower that.
            ir_node* sel = get_Mux_sel(node);
            if (isCmpFProjB(sel)) return true;
#endif
            
            return !(mode_is_int(get_irn_mode(node)) ||
                    (get_irn_mode(node) == mode_b));
#endif
        }
        
        void postInlineOpt(ir_graph* graph)
        {
            // Alas we can't pass information to this callback, so just create
            // new pass instances here and run them. These passes don't even
            // have configuration settings, so it's okay.
            // Also when inlining is active, all passes except combo are active.
            opt::ScalarReplacePass scalarReplacePass;
            opt::LocalOptPass      localOptPass;
            opt::ControlFlowPass   controlFlowPass;
            //opt::ComboPass         comboPass;
            
            scalarReplacePass.run(graph);
            localOptPass.run(graph);
            controlFlowPass.run(graph);
        }

        const ir_settings_arch_dep_t* backendArchFactory()
        {
            // Use the backends optimization settings.
            return be_get_backend_param()->dep_param;
        }
    }
    
    CParserOptimizer::CParserOptimizer()
        : archFactory               (0),
          lowerDwordIsEnabled       (indeterminate),
          aliasAnalysisLevel        (AliasAnalysisLevel::Default),
          archOptIsEnabled          (true),
          callConvOptIsEnabled      (true),
          localCseIsEnabled         (true),
          localFoldingIsEnabled     (true),
          localControlFlowIsEnabled (true)
    {
        // Only lower unsupported muxes.
        getPass<opt::LowerMuxPass>()->setCallback(isUnsupportedMux);
        getPass<opt::InlinePass>()->setCallback(postInlineOpt);
    }
    
    void CParserOptimizer::setupDwordLowering()
    {
        bool isEnabled = lowerDwordIsEnabled;
        
        // For indeterminate, ask the backend.
        if (indeterminate(lowerDwordIsEnabled))
        {
            isEnabled = be_get_backend_param()->do_dw_lowering;
        }
        
        getPass<opt::LowerDwordPass>()->setIsEnabled(isEnabled);
    }
    
    void CParserOptimizer::setupAliasAnalysis()
    {
        // The alias level replaces alias_analysis, strict_alias and no_alias
        // in cparsers firm_opt structure.
        set_opt_alias_analysis(
            aliasAnalysisLevel != AliasAnalysisLevel::Disabled
        );
        
        int settings = aa_opt_no_opt;
        switch (aliasAnalysisLevel)
        {
        case AliasAnalysisLevel::NoAlias:
            settings = aa_opt_no_alias;
            break;
            
        case AliasAnalysisLevel::Strict:
            settings |= aa_opt_type_based | aa_opt_byte_type_may_alias;
            break;
        }
        
        set_irp_memory_disambiguator_options(settings);
    }
    
    void CParserOptimizer::printDebugSummary()
    {
        // Print a summary of the selected passes and options.
        for (PassMap::iterator it = passes.begin(),
            eit = passes.end(); it != eit; it++)
        {
            if (!it->second->getIsEnabled()) continue;
            log::debug << "Selected pass: " << it->second->getName() << log::end;
        }
        
        log::debug << "Alias analysis:     " << AliasAnalysisLevel::
            toString(aliasAnalysisLevel) << log::end;
        
        log::debug << "Omit frame pointer: " << omitFPIsEnabled << log::end;
        log::debug << "Arch-dep. opt.:     " << archOptIsEnabled << log::end;
        log::debug << "Calling-conv. opt.: " << callConvOptIsEnabled << log::end;
    }
    
    void CParserOptimizer::setOptLevel(int level)
    {
        if ((level < 0) || (level > 3))
        {
            throw std::invalid_argument("Invalid optimization level");
        }
        
        // Optimization      | -O0 | -O1 | -O2 | -O3 |
        // ------------------+-----+-----+-----+-----+
        // bool              |     |     |     |     |
        // combo             |     |     |     |     |
        // control-flow      |     |  x  |  x  |  x  |
        // dead              |     |  x  |  x  |  x  |
        // deconv            |     |  x  |  x  |  x  |
        // gvn-pre           |     |     |     |     |
        // if-conversion     |     |     |     |  x  |
        // inline            |     |     |  x  |  x  |
        // invert-loops      |     |     |     |     |
        // ivopts            |     |  x  |  x  |  x  |
        // local             |     |  x  |  x  |  x  |
        // lower             |  x  |  x  |  x  |  x  |
        // lower-const       |  x  |  x  |  x  |  x  |
        // lower-dw          |  x  |  x  |  x  |  x  |
        // lower-mux         |  x  |  x  |  x  |  x  |
        // lower-switch      |  x  |  x  |  x  |  x  |
        // one-return        |     |     |     |     |
        // opt-func-call     |     |  x  |  x  |  x  |
        // opt-load-store    |     |  x  |  x  |  x  |
        // opt-proc-clone    |     |     |     |     |
        // opt-tail-rec      |     |  x  |  x  |  x  |
        // parallelize-mem   |     |     |     |     |
        // peel-loops        |     |     |     |     |
        // reassociation     |     |  x  |  x  |  x  |
        // remove-phi-cycles |     |     |     |     |
        // remove-unused     |     |  x  |  x  |  x  |
        // scalar-replace    |     |  x  |  x  |  x  |
        // shape-blocks      |     |     |     |     |
        // thread-jumps      |     |     |     |  x  |
        // confirm           |     |  x  |  x  |  x  |
        // remove-confirms   |     |  x  |  x  |  x  |
        // gcse              |     |  x  |  x  |  x  |
        // place             |     |     |     |     |
        // ------------------+-----+-----+-----+-----+
        // alias-analysis    | dis | def | str | str |
        // omit-fp           |     |     |  x  |  x  |
        // arch-opt          |     |  x  |  x  |  x  |
        // call-conv-opt     |     |  x  |  x  |  x  |
        // local-cse         |     |  x  |  x  |  x  |
        // local-fold        |  x  |  x  |  x  |  x  |
        // local-cf          |  x  |  x  |  x  |  x  |
        
        // Turn off all passes at first.
        setAllIsEnabled(false);
        
        // Turn on the essential lowering passes in any case.
        getPass<opt::LowerPass>()       ->setIsEnabled(true);
        getPass<opt::LowerConstPass>()  ->setIsEnabled(true);
        getPass<opt::LowerDwordPass>()  ->setIsEnabled(true);
        getPass<opt::LowerSwitchPass>() ->setIsEnabled(true);
        getPass<opt::LowerMuxPass>()    ->setIsEnabled(true);
        
        // Turn on gcse, confirm, remove-confirm and set alias etc.
        getPass<opt::GlobalCSEPass>()      ->setIsEnabled(true);
        getPass<opt::AddConfirmsPass>()    ->setIsEnabled(true);
        getPass<opt::RemoveConfirmsPass>() ->setIsEnabled(true);
        
        aliasAnalysisLevel        = AliasAnalysisLevel::Default;
        omitFPIsEnabled           = false;
        archOptIsEnabled          = true;
        callConvOptIsEnabled      = true;
        localCseIsEnabled         = true;
        localFoldingIsEnabled     = true;
        localControlFlowIsEnabled = true;
        
        switch (level)
        {        
        case 3:
            getPass<opt::JumpthreadingPass>() ->setIsEnabled(true);
            getPass<opt::IfConversionPass>()  ->setIsEnabled(true);
            // Fall-through to O2.
            
        case 2:
            getPass<opt::InlinePass>()->setIsEnabled(true);
            
            aliasAnalysisLevel = AliasAnalysisLevel::Strict;
            omitFPIsEnabled    = true;
            // Fall-through to O1.
            
        case 1:
            // Turn on some safe and cheap optimizations.
            getPass<opt::RemoveUnusedPass>()    ->setIsEnabled(true);
            getPass<opt::TailRecursionPass>()   ->setIsEnabled(true);
            getPass<opt::OptimizeCallsPass>()   ->setIsEnabled(true);
            getPass<opt::ReassociationPass>()   ->setIsEnabled(true);
            getPass<opt::ControlFlowPass>()     ->setIsEnabled(true);
            getPass<opt::LocalOptPass>()        ->setIsEnabled(true);
            getPass<opt::ScalarReplacePass>()   ->setIsEnabled(true);
            getPass<opt::CodePlacementPass>()   ->setIsEnabled(true);
            getPass<opt::AddConfirmsPass>()     ->setIsEnabled(true);
            getPass<opt::RemoveConfirmsPass>()  ->setIsEnabled(true);
            getPass<opt::LoadStoreOptPass>()    ->setIsEnabled(true);
            getPass<opt::DeconvPass>()          ->setIsEnabled(true);
            getPass<opt::IVOptPass>()           ->setIsEnabled(true);
            getPass<opt::RemoveDeadNodesPass>() ->setIsEnabled(true);
            break;
            
        case 0:
            // Disable gcse, confirm and alias analysis.
            getPass<opt::GlobalCSEPass>()      ->setIsEnabled(false);
            getPass<opt::AddConfirmsPass>()    ->setIsEnabled(false);
            getPass<opt::RemoveConfirmsPass>() ->setIsEnabled(false);

            aliasAnalysisLevel   = AliasAnalysisLevel::Disabled;
            archOptIsEnabled     = false;
            callConvOptIsEnabled = false;
            localCseIsEnabled    = false;
            break;
        }

        printDebugSummary();
    }
    
    void CParserOptimizer::setArchFactory(arch_dep_params_factory_t archFactory)
    {
        this->archFactory = archFactory;
    }
    
    // Optimization settings related to individual passes.        
    void CParserOptimizer::setIfConversionSettings(const ir_settings_if_conv_t* settings)
    {
        getPass<opt::IfConversionPass>()->setSettings(settings);
    }
    
    // Inlining and cloning.
    void CParserOptimizer::setInlineMaxSize(unsigned maxSize)
    {
        getPass<opt::InlinePass>()->setMaxSize(maxSize);
    }
    
    void CParserOptimizer::setInlineThreshold(unsigned threshold)
    {
        getPass<opt::InlinePass>()->setThreshold(threshold);
    }
    
    void CParserOptimizer::setCloningThreshold(unsigned threshold)
    {
        getPass<opt::CloningPass>()->setThreshold(threshold);
    }
    
    // Lowering settings.
    void CParserOptimizer::setSwitchSpareSize(unsigned spareSize)
    {
        getPass<opt::LowerSwitchPass>()->setSpareSize(spareSize);
    }
    
    void CParserOptimizer::setLowerDwordSettings(const lwrdw_param_t* settings)
    {
        getPass<opt::LowerDwordPass>()->setSettings(settings);
    }
    
    // Can be set to indeterminate, to let optimize() decide what to do,
    // depending on the current backend parameters.
    void CParserOptimizer::setLowerDwordIsEnabled(tribool lowerDword)
    {
        this->lowerDwordIsEnabled = lowerDwordIsEnabled;
    }
    
    void CParserOptimizer::setCallConvOptIsEnabled(bool callConvOptIsEnabled)
    {
        this->callConvOptIsEnabled = callConvOptIsEnabled;
    }
    
    void CParserOptimizer::prepareConvert()
    {
        log::debug << "Preparing graph construction" << log::end;

        // Initialize arch dependent optimizations, but disable them during
        // the construction phase.
        arch_dep_init((archFactory == 0) ? backendArchFactory : archFactory);
        arch_dep_set_opts(arch_dep_none);
        
        // Set optimizations applied during construction.
        set_optimize                     (true);
        set_opt_constant_folding         (localFoldingIsEnabled);
        set_opt_algebraic_simplification (localFoldingIsEnabled);
        set_opt_cse                      (localCseIsEnabled);
        set_opt_global_cse               (false);
        set_opt_unreachable_code         (true);
        set_opt_control_flow             (localControlFlowIsEnabled);
        
        set_opt_control_flow_weak_simplification   (true);
        set_opt_control_flow_strong_simplification (true);
    }
    
    void CParserOptimizer::prepareBackend()
    {
        be_parse_arg(omitFPIsEnabled ? "omitfp" : "omitfp=no");
    }
    
    void CParserOptimizer::run()
    {
        preLower();

        // This is basically the same strategy used by cparser.
        setupAliasAnalysis();

        log::debug << "Dead code elimination" << log::end;
        
        // Note: the RTS pass is not needed (at least for now), because the
        // converter won't create runtime calls.
        
        // Firm kill dead code.
        for (int i = 0; i < get_irp_n_irgs(); i++)
        {
            ir_graph* graph = get_irp_irg(i);
            
            getPass<opt::ComboPass>()       ->run(graph);
            getPass<opt::LocalOptPass>()    ->run(graph);
            getPass<opt::ControlFlowPass>() ->run(graph);
        }
        
        getPass<opt::RemoveUnusedPass>()->run();
        
        log::debug << "Applying optimizations" << log::end;
        
        getPass<opt::TailRecursionPass>() ->run();
        getPass<opt::OptimizeCallsPass>() ->run();
        getPass<opt::LowerConstPass>()    ->run();
        
        for (int i = 0; i < get_irp_n_irgs(); i++)
        {
            ir_graph* graph = get_irp_irg(i);
            
            getPass<opt::ScalarReplacePass>() ->run(graph);
            getPass<opt::InvertLoopsPass>()   ->run(graph);
            getPass<opt::LocalOptPass>()      ->run(graph);
            getPass<opt::ReassociationPass>() ->run(graph);
            getPass<opt::LocalOptPass>()      ->run(graph);
            getPass<opt::GlobalCSEPass>()     ->run(graph);
            
            if (getPass<opt::AddConfirmsPass>()->getIsEnabled())
            {
                // Control flow optimization enables the confirm pass to
                // handle more advanced situations, too.
                getPass<opt::ControlFlowPass>() ->run(graph);
                getPass<opt::AddConfirmsPass>() ->run(graph);
                getPass<opt::LocalOptPass>()    ->run(graph);
            }
            
            getPass<opt::ControlFlowPass>()   ->run(graph);
            getPass<opt::LoadStoreOptPass>()  ->run(graph);
            getPass<opt::LowerPass>()         ->run(graph);
            getPass<opt::DeconvPass>()        ->run(graph);
            getPass<opt::JumpthreadingPass>() ->run(graph);
            
            if (getPass<opt::AddConfirmsPass>()->getIsEnabled())
            {
                getPass<opt::RemoveConfirmsPass>() ->run(graph);
            }
            
            getPass<opt::GvnPrePass>()        ->run(graph);
            getPass<opt::CodePlacementPass>() ->run(graph);
            getPass<opt::ControlFlowPass>()   ->run(graph);
            
            if (getPass<opt::IfConversionPass>()->getIsEnabled())
            {
                getPass<opt::IfConversionPass>() ->run(graph);
                getPass<opt::LocalOptPass>()     ->run(graph);
                getPass<opt::ControlFlowPass>()  ->run(graph);
            }
            
            getPass<opt::BoolOptPass>()         ->run(graph);
            getPass<opt::BlockShapingPass>()    ->run(graph);
            getPass<opt::LowerSwitchPass>()     ->run(graph);
            getPass<opt::IVOptPass>()           ->run(graph);
            getPass<opt::LocalOptPass>()        ->run(graph);
            getPass<opt::RemoveDeadNodesPass>() ->run(graph);
        }

        getPass<opt::InlinePass>()  ->run();
        getPass<opt::CloningPass>() ->run();
        
        for (int i = 0; i < get_irp_n_irgs(); i++)
        {
            ir_graph* graph = get_irp_irg(i);
            
            getPass<opt::LocalOptPass>()      ->run(graph);
            getPass<opt::ControlFlowPass>()   ->run(graph);
            getPass<opt::JumpthreadingPass>() ->run(graph);
            getPass<opt::LocalOptPass>()      ->run(graph);
            getPass<opt::ControlFlowPass>()   ->run(graph);
        }
        
        getPass<opt::RemoveUnusedPass>()->run();
        
        postLower();
        
        // Fix remaining frame types.
        repairFrameTypes();
        finalizeFrameTypes();
    }
    
    void CParserOptimizer::preLower()
    {
        log::debug << "Lowering compound parameters/returns" << log::end;
        
        // Kill unreachable code before lowering.
        for (int i = 0; i < get_irp_n_irgs(); i++)
        {
            ir_graph* graph = get_irp_irg(i);
            getPass<opt::ControlFlowPass>()->run(graph);
        }
        
        lower_params_t lowerCompoundParams;
        lowerCompoundParams.def_ptr_alignment    = 4;
        lowerCompoundParams.flags                = LF_COMPOUND_RETURN | LF_RETURN_HIDDEN;
        lowerCompoundParams.hidden_params        = ADD_HIDDEN_ALWAYS_IN_FRONT;
        lowerCompoundParams.find_pointer_type    = 0;
        lowerCompoundParams.ret_compound_in_regs = 0;
        lower_calls_with_compounds(&lowerCompoundParams);

        log::debug << "Lowering CopyB nodes" << log::end;
        
        // Parameters are taken from cparser.
        for (int i = 0; i < get_irp_n_irgs(); i++)
        {
            ir_graph* graph = get_irp_irg(i);
            lower_CopyB(graph, 128, 4);
        }
    }
    
    void CParserOptimizer::postLower()
    {
        log::debug << "Lowering dword nodes" << log::end;
        
        // Lower the program.
        setupDwordLowering();
        getPass<opt::LowerDwordPass>()->run();
        
        log::debug << "Applying post-lowering optimizations" << log::end;
        
        // Do optimizations.
        for (int i = 0; i < get_irp_n_irgs(); i++)
        {
            ir_graph* graph = get_irp_irg(i);
            getPass<opt::ReassociationPass>()->run(graph);
        }
        
        // Apply architecture dependant optimizations.
        if (archOptIsEnabled)
        {
            arch_dep_set_opts(static_cast<arch_dep_opts_t>(
                arch_dep_mul_to_shift |
                arch_dep_div_by_const |
                arch_dep_mod_by_const
            ));
        }
        
        for (int i = 0; i < get_irp_n_irgs(); i++)
        {
            ir_graph* graph = get_irp_irg(i);
            
            // Do graph-local optimizations.
            getPass<opt::LocalOptPass>()     ->run(graph);
            getPass<opt::GlobalCSEPass>()    ->run(graph);
            getPass<opt::LoadStoreOptPass>() ->run(graph);
            getPass<opt::LocalOptPass>()     ->run(graph);
            getPass<opt::ControlFlowPass>()  ->run(graph);
            
            if (getPass<opt::IfConversionPass>()->getIsEnabled())
            {
                getPass<opt::IfConversionPass>() ->run(graph);
                getPass<opt::LocalOptPass>()     ->run(graph);
                getPass<opt::ControlFlowPass>()  ->run(graph);
            }
            
            getPass<opt::ParallelizeMemoryPass>()->run(graph);
            
#ifdef LOWER_CMPF_PROJB_CONV
            replaceCmpFConvB(graph);
#endif
            getPass<opt::LowerMuxPass>()->run(graph);
        }
        
        if (callConvOptIsEnabled)
        {
            mark_private_methods();
        }

        // Set the phase to low.
        for (int i = 0; i < get_irp_n_irgs(); i++)
        {
            ir_graph* graph = get_irp_irg(i);
            set_irg_phase_low(graph);
        }
        
        set_irp_phase_state(phase_low);
    }
}
