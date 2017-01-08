#ifndef LTF_FACADE_CONVERTER_HPP_
#define LTF_FACADE_CONVERTER_HPP_

#include <string>
#include <libfirm/firm_types.h>
#include "../Typedef/Pointer.hpp"
#include "../RAII/FirmHandle.hpp"

namespace ltf
{
    // The various stages the program will go through for conversion.
    struct ProgramStage
    {
        enum Enum
        {
            Unparsed  = 0,
            Parsed    = 1,
            Verified  = 2,
            Prepared  = 3,
            Converted = 4,
            Optimized = 5,
            Finished  = 6
        };
    };
    
    typedef ProgramStage::Enum ProgramStageE;
    
    struct FPModel
    {
        enum Enum
        {
            Fast,
            Strict,
            Precise
        };
    };

    typedef FPModel::Enum FPModelE;
    
    class Converter
    {
    private:
        ProgramStageE currentStage;
        ModuleSPtr    module;
        ir_prog*      program;
        
        ParserSPtr    parser;
        OptimizerSPtr optimizer;
        BackendSPtr   backend;
        
        std::string   inputFilename;
        std::string   outputFilename;
        
        FPModelE      fpModel;
        
    public:
        Converter(FirmHandle& firmHandle);
        
        // Get/set the conversion components.
        void setParser    (ParserSPtr    parser);
        void setOptimizer (OptimizerSPtr optimizer);
        void setBackend   (BackendSPtr   backend);
        
        ParserSPtr    getParser();
        OptimizerSPtr getOptimizer();
        BackendSPtr   getBackend();
        
        // Set conversion options. Calls are delegated to parser, writer or
        // optimizer, which may provide additional settings.
        void setOptLevel     (int level);
        void setArchitecture (const std::string& architecture);
        void setInputFile    (const std::string& filename);
        void setOutputFile   (const std::string& filename);
        void setFPModel      (FPModelE fpModel);
        
        // Run conversion up to a certain stage. Allows for immediate result
        // dumps, and output of immediate program code.
        void runParse();    // Parse the input file
        void runVerify();   // Verify the parsed module
        void runPrepare();  // Run required lowering on the module
        void runConvert();  // Convert the module to a firm program
        void runOptimize(); // Optimize and lower the firm program
        void runBackend();  // Run the backend to produce assembler code
        
        // Run full conversion.
        void run();
        
        // Import or export the (lowered) firm program.
        void exportFirm(const std::string& filename, bool lowered = false);
        void importFirm(const std::string& filename, bool lowered = false);
        
        // Provide access to immediate code (although firms getProgram() is
        // a bit pointless, due to firms global state).
        ModuleSPtr    getModule();
        ir_prog*      getProgram();
        ProgramStageE getCurrentStage();
    };
}

#endif /* LTF_FACADE_CONVERTER_HPP_ */
