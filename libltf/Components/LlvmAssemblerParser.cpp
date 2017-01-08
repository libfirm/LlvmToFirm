#include "LlvmAssemblerParser.hpp"

#include <llvm/Module.h>
#include <llvm/Assembly/Parser.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>
#include "../Exceptions/ParseException.hpp"
using namespace boost;

namespace ltf
{
    ModuleSPtr LlvmAssemblerParser::run(const std::string& filename)
    {
        llvm::SMDiagnostic diagnostic;
        llvm::LLVMContext& llvmContext = llvm::getGlobalContext();
    
        // Let LLVM parse the assembly file.
        ModuleSPtr module = shared_ptr<llvm::Module>(
            llvm::ParseAssemblyFile(filename, diagnostic, llvmContext)
        );
    
        if (module.get() == 0)
        {
            // Extract the error message.
            std::string error;
            llvm::raw_string_ostream errorStream(error);
            diagnostic.Print("LlvmToFirm", errorStream);
    
            throw ParseException(errorStream.str());
        }

        return module;
    }
}
