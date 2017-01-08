#ifndef LTF_FACADE_BACKEND_HPP_
#define LTF_FACADE_BACKEND_HPP_

#include <string>
#include "../Typedef/Pointer.hpp"

namespace ltf
{
    class Backend
    {
    public:
        // Set the architecture to use.
        virtual void setArchitecture(const std::string& architecture) = 0;
        
        virtual void setCompilationUnitName(
            const std::string& compilationUnitName
        ) = 0;

        // Set backend parameters that may be relevant during the conversion
        // or optimization phases.
        virtual void prepareConvert() = 0;

        // Run the actual backend.
        virtual void run(const std::string& filename) = 0;
    };
}

#endif /* LTF_FACADE_BACKEND_HPP_ */
