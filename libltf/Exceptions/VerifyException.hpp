#ifndef LTF_EXC_VERIFY_EXCEPTION_HPP_
#define LTF_EXC_VERIFY_EXCEPTION_HPP_

#include "LlvmException.hpp"

namespace ltf
{
    // Indicates an error that occurred while verifying the LLVM input.
    class VerifyException : public LlvmException
    {
    public:
        VerifyException(const std::string& llvmMessage) throw()
            : LlvmException(format(llvmMessage)) { }
        virtual ~VerifyException() throw() { }

    private:
        static std::string format(const std::string& llvmMessage);
    };
}

#endif // LTF_EXC_VERIFY_EXCEPTION_HPP_
