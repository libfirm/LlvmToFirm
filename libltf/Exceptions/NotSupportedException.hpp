#ifndef LTF_EXC_NOT_SUPPORTED_EXCEPTION_HPP_
#define LTF_EXC_NOT_SUPPORTED_EXCEPTION_HPP_

#include <stdexcept>

namespace ltf
{
    class NotSupportedException : public std::runtime_error
    {
    public:
        NotSupportedException(const std::string& message) throw()
            : runtime_error(format(message)) { }
        virtual ~NotSupportedException() throw() { }
        
    private:
        static std::string format(const std::string& message);
    };
}

#endif /* LTF_EXC_NOT_SUPPORTED_EXCEPTION_HPP_ */
