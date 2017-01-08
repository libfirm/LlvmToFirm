#include "Converter.hpp"

#include <cassert>
#include <boost/foreach.hpp>
#include <llvm/Module.h>
#include <llvm/Function.h>
#include <llvm/PassManager.h>
#include <llvm/Transforms/IPO.h>
#include <llvm/Transforms/Scalar.h>
#include <llvm/Target/TargetData.h>
#include <llvm/Analysis/Verifier.h>
#include "Context.hpp"
#include "../Components/LlvmBitcodeParser.hpp"
#include "../Components/CParserOptimizer.hpp"
#include "../Components/DefaultBackend.hpp"
#include "../RAII/TimedScope.hpp"
#include "../Util/Logging.hpp"
#include "../Exceptions/VerifyException.hpp"
#include "../Lowering/LowerIntrinsicsPass.hpp"
#include "../Lowering/LowerInstructionsPass.hpp"
#include "../Builders/GraphBuilder.hpp"
#include "../Builders/EntityBuilder.hpp"

namespace ltf
{
    Converter::Converter(FirmHandle& firmHandle)
        : currentStage (ProgramStage::Unparsed),
          parser       (new LlvmBitcodeParser()),
          optimizer    (new CParserOptimizer()),
          backend      (new DefaultBackend()),
          fpModel      (FPModel::Precise)
    { }
    
    // Component getters/setters.
    
    void Converter::setParser(ParserSPtr parser)
    {
        assert(parser.get() != 0);
        this->parser = parser;
    }
    
    void Converter::setOptimizer(OptimizerSPtr optimizer)
    {
        assert(optimizer.get() != 0);
        this->optimizer = optimizer;
    }
    
    void Converter::setBackend(BackendSPtr backend)
    {
        assert(backend.get() != 0);
        this->backend = backend;
    }
    
    ParserSPtr Converter::getParser()
    {
        return parser;
    }
    
    OptimizerSPtr Converter::getOptimizer()
    {
        return optimizer;
    }
    
    BackendSPtr Converter::getBackend()
    {
        return backend;
    }
    
    // Convenience methods.
    
    void Converter::setOptLevel(int level)
    {
        optimizer->setOptLevel(level);
    }
    
    void Converter::setArchitecture(const std::string& architecture)
    {
        backend->setArchitecture(architecture);
    }
    
    void Converter::setInputFile(const std::string& filename)
    {
        inputFilename = filename;
    }
    
    void Converter::setOutputFile(const std::string& filename)
    {
        outputFilename = filename;
    }
    
    void Converter::setFPModel(FPModelE fpModel)
    {
        assert(
            (currentStage < ProgramStage::Converted) &&
            "Please set the FP model prior to conversion."
        );
        
        this->fpModel = fpModel;
    }
    
    // Actual conversion functions.
    
    void Converter::runParse()
    {
        assert(currentStage == ProgramStage::Unparsed);
        assert(!inputFilename.empty() && "Invalid input filename");
     
        TimedScope logTime("Parsing");
        log::info << "Parsing module" << log::end;
        
        module = parser->run(inputFilename);
        currentStage = ProgramStage::Parsed;
    }
    
    void Converter::runVerify()
    {
        if (currentStage < ProgramStage::Parsed) runParse();
        assert(currentStage < ProgramStage::Verified);
        
        TimedScope logTime("Verification");
        log::info << "Verifying module" << log::end;
        
        // Verify the module using LLVMs verifier.
        std::string errorString;
        if (llvm::verifyModule(*module, llvm::ReturnStatusAction, &errorString))
        {
            throw VerifyException(errorString);
        }
        
        currentStage = ProgramStage::Verified;
    }
    
    void Converter::runPrepare()
    {
        if (currentStage < ProgramStage::Verified) runVerify();
        assert(currentStage < ProgramStage::Prepared);
        
        TimedScope logTime("Preparation");
        log::info << "Preparing module" << log::end;
        
        // Lower high-level constructs that can't be converted directly.
        // Note that the pass manager takes ownership of the passes and will
        // destruct them in the end.
        llvm::PassManager passManager;
        passManager.add(new llvm::TargetData(module.get()));
        passManager.add(new LowerIntrinsicsPass());
        passManager.add(new LowerInstructionsPass());
        
        // Free is problematic, since firms free node requires more information,
        // than LLVM provides. LLVM will only provide a pointer, firm will also
        // need the type of the object to free. Lower this to malloc and free.
        passManager.add(llvm::createLowerAllocationsPass());
        passManager.add(llvm::createStripDeadPrototypesPass());
        passManager.run(*module.get());
        
        currentStage = ProgramStage::Prepared;
    }
    
    void Converter::runConvert()
    {
        if (currentStage < ProgramStage::Prepared) runPrepare();
        assert(currentStage < ProgramStage::Converted);
        
        TimedScope logTime("Conversion");
        log::info << "Converting module" << log::end;

        backend->prepareConvert();
        optimizer->prepareConvert();
        
        // Prepare the transformation context;
        Context context(module);
        context.getGraphBuilder()->setFPModel(fpModel);

        // Build entities up-front. Note that this is actually a case, where
        // on-demand-building is required during the building phase. For example
        // an initializer for a pointer value may require an entity that isn't
        // yet constructed.
        BOOST_FOREACH (llvm::Function& function, module->getFunctionList())
        {
            if (function.isIntrinsic()) continue;
                        
            context.getEntityBuilder()->build(&function);
        }

        // Functions should be constructed before the variables, so that the
        // constructor functions are available, when converting llvm.global_ctor
        // and llvm.global_dtor.
        BOOST_FOREACH (llvm::GlobalVariable& variable, module->getGlobalList())
        {
            context.getEntityBuilder()->build(&variable);
        }
        
        context.getEntityBuilder()->disableConstruction();

        // Build each function graph.
        context.getGraphBuilder()->disableOnDemandConstruction();
        BOOST_FOREACH (llvm::Function& function, module->getFunctionList())
        {
            // Skip functions without a body.
            if (function.isDeclaration()) continue;
            
            if (function.getLinkage() == llvm::
                GlobalValue::AvailableExternallyLinkage)
            {
                // See the EntityBuilder for an explanation. Simply put, the
                // function is available elsewhere and we don't need a copy.
                continue;
            }
            
            context.getGraphBuilder()->build(&function);
        }
        
        context.getGraphBuilder()->disableConstruction();
        set_irp_phase_state(phase_high);

        tr_vrfy();
        
        program = get_irp();
        currentStage = ProgramStage::Converted;
    }
    
    void Converter::runOptimize()
    {
        if (currentStage < ProgramStage::Converted) runConvert();
        assert(currentStage < ProgramStage::Optimized);
        
        TimedScope logTime("Optimization");
        log::info << "Optimizing program" << log::end;
        
        optimizer->run();
        
        currentStage = ProgramStage::Optimized;
    }
    
    void Converter::runBackend()
    {
        if (currentStage < ProgramStage::Optimized) runOptimize();
        assert(currentStage < ProgramStage::Finished);
        assert(!outputFilename.empty() && "Invalid output filename");
        
        TimedScope logTime("Backend");
        log::info << "Running backend" << log::end;
        
        optimizer->prepareBackend();
        backend->setCompilationUnitName(module->getModuleIdentifier());
        backend->run(outputFilename);
        
        currentStage = ProgramStage::Finished;
    }
    
    void Converter::exportFirm(const std::string& filename, bool lowered)
    {
        assert(!filename.empty());
        
        // Determine the source stage we need.
        ProgramStageE sourceStage = lowered ?
            ProgramStage::Optimized : ProgramStage::Converted;
        
        // Convert or optimized, if not already done.
        if ( lowered && (currentStage < sourceStage)) runOptimize();
        if (!lowered && (currentStage < sourceStage)) runConvert();
        
        if (!lowered)
        {
            assert((currentStage == sourceStage) &&
                "Program is already lowered");
        }
        
        ir_export(filename.c_str());
    }
    
    void Converter::importFirm(const std::string& filename, bool lowered)
    {
        assert(!filename.empty());
        
        // Make sure, that nothing really happened up to here.
        assert(
            (currentStage == ProgramStage::Unparsed) &&
            "Can't import a firm-program in the middle of a conversion"
        );
        
        // Import the program, set the appropriate stage.
        ir_import(filename.c_str());
        currentStage = lowered ? ProgramStage::Optimized : ProgramStage::Converted;
    }
    
    void Converter::run()
    {
        runBackend();
    }
    
    ModuleSPtr Converter::getModule()
    {
        return module;
    }
    
    ir_prog* Converter::getProgram()
    {
        return program;
    }
    
    ProgramStageE Converter::getCurrentStage()
    {
        return currentStage;
    }
}
