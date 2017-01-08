#ifndef LTF_CMP_OPTIMIZER_HPP_
#define LTF_CMP_OPTIMIZER_HPP_

#include <boost/logic/tribool.hpp>
#include "../Facade/Optimizer.hpp"

namespace ltf
{    
    // The cparser-inspired default optimizer used by LTF. An optimization
    // level like that on the command line can be specified, to toggle various
    // optimization settings and passes.
    class CParserOptimizer : public Optimizer
    {
    private:
        struct AliasAnalysisLevel
        {
            enum Enum
            {
                Disabled,
                NoAlias,
                Default,
                Strict
            };
            
            static std::string toString(Enum value)
            {
                switch (value)
                {
                case Disabled: return "Disabled";
                case Default:  return "Default";
                case Strict:   return "Strict";
                case NoAlias:  return "NoAlias";
                default:       return "Invalid";
                }
            };
        };
        
        typedef AliasAnalysisLevel::Enum AliasAnalysisLevelE;
        
        // Several optimization flags.
        arch_dep_params_factory_t archFactory;
        boost::logic::tribool     lowerDwordIsEnabled;
        AliasAnalysisLevelE       aliasAnalysisLevel;
        
        bool omitFPIsEnabled;
        bool archOptIsEnabled;
        bool callConvOptIsEnabled;
        
        // Local optimizations during construction.
        bool localCseIsEnabled;
        bool localFoldingIsEnabled;
        bool localControlFlowIsEnabled;
        
        void printDebugSummary();
        
        // Prepare optimization stages.
        void setupDwordLowering();
        void setupAliasAnalysis();
        
        // Lowering of firm code before and after optimization.
        void preLower();
        void postLower();
        
    public:
        CParserOptimizer();

        void prepareConvert();
        void prepareBackend();
        void run();
        
        // Optimization settings.
        void setOptLevel             (int level);
        void setArchFactory          (arch_dep_params_factory_t archFactory);
        void setIfConversionSettings (const ir_settings_if_conv_t* settings);
        void setInlineMaxSize        (unsigned maxSize);
        void setInlineThreshold      (unsigned threshold);
        void setCloningThreshold     (unsigned threshold);
        void setSwitchSpareSize      (unsigned spareSize);
        void setLowerDwordSettings   (const lwrdw_param_t* settings);
        void setLowerDwordIsEnabled  (boost::logic::tribool lowerDword);
        void setCallConvOptIsEnabled (bool callConvOptIsEnabled);
    };
}

#endif /* LTF_CMP_OPTIMIZER_HPP_ */
