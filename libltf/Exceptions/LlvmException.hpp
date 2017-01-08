#ifndef LTF_EXC_LLVM_EXCEPTION_HPP_
#define LTF_EXC_LLVM_EXCEPTION_HPP_

#include <string>
#include <stdexcept>

namespace ltf
{
    // Indicates an error related to the LLVM input file.
    class LlvmException : public std::runtime_error
    {
    public:
        LlvmException(const std::string& message) throw()
            : runtime_error(message) { }
        virtual ~LlvmException() throw() { }
    };
}

#endif // LTF_EXC_LLVM_EXCEPTION_HPP_
