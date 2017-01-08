#ifndef LTF_EXC_NOT_IMPLEMENTED_EXCEPTION_HPP_
#define LTF_EXC_NOT_IMPLEMENTED_EXCEPTION_HPP_

#include <stdexcept>

namespace ltf
{
    class NotImplementedException : public std::runtime_error
    {
    public:
        NotImplementedException(const std::string& message) throw()
            : runtime_error(format(message)) { }
        virtual ~NotImplementedException() throw() { }
        
    private:
        static std::string format(const std::string& message);
    };
}

#endif /* LTF_EXC_NOT_IMPLEMENTED_EXCEPTION_HPP_ */
