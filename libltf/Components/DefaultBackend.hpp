#ifndef LTF_CMP_DEFAULT_BACKEND_HPP_
#define LTF_CMP_DEFAULT_BACKEND_HPP_

#include <string>
#include "../Facade/Backend.hpp"

namespace ltf
{
    class DefaultBackend : public Backend
    {
    private:
        std::string architecture;
        std::string compilationUnitName;
        
    public:
        DefaultBackend()
            : architecture("i686"),
              compilationUnitName("unknown")
        { }
        
        void setArchitecture        (const std::string& architecture);
        void setCompilationUnitName (const std::string& compilationUnitName);

        void prepareConvert();
        void run(const std::string& filename);
    };
}

#endif /* LTF_CMP_DEFAULT_BACKEND_HPP_ */
