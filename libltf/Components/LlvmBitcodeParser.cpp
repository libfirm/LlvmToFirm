#include "LlvmBitcodeParser.hpp"

#include <llvm/Module.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/Bitcode/ReaderWriter.h>
#include "../Exceptions/ParseException.hpp"
using namespace boost;

namespace ltf
{
    ModuleSPtr LlvmBitcodeParser::run(const std::string& filename)
    {
        // Not sure, how this is supposed to be used.
        llvm::LLVMContext& llvmContext = llvm::getGlobalContext();

        std::string errorString;

        // Load the file into a memory buffer.
        shared_ptr<llvm::MemoryBuffer> buffer = shared_ptr<llvm::MemoryBuffer>(
            llvm::MemoryBuffer::getFile(filename.c_str(), &errorString));
        if (buffer.get() == 0) throw ParseException(errorString);

        // Use the bitcode reader, to obtain the module.
        ModuleSPtr module = shared_ptr<llvm::Module>(
            llvm::ParseBitcodeFile(buffer.get(), llvmContext, &errorString)
        );
        
        if (module.get() == 0) throw ParseException(errorString);
        return module;
    }
}
