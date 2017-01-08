#include "DefaultBackend.hpp"

#include <libfirm/firm.h>
#include "../RAII/FileHandle.hpp"
#include "../Util/Logging.hpp"

namespace ltf
{
    void DefaultBackend::setArchitecture(const std::string& architecture)
    {
        this->architecture = architecture;
    }

    void DefaultBackend::setCompilationUnitName(
        const std::string& compilationUnitName)
    {
        this->compilationUnitName = compilationUnitName;
    }
    
    void DefaultBackend::prepareConvert()
    {
        // Set the architecture (affects dword lowering).
        be_parse_arg("ia32-gasmode=elf");
        be_parse_arg((std::string("ia32-arch=") + architecture).c_str());
        log::debug << "Backend architecture: " << architecture << log::end;
    }
    
    void DefaultBackend::run(const std::string& filename)
    {
        // Run everything through the backend.
        FileHandle fileHandle(filename.c_str(), "w");
        be_main(fileHandle.get(), compilationUnitName.c_str());
    }
}
