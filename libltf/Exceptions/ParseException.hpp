#ifndef LTF_EXC_PARSE_EXCEPTION_HPP_
#define LTF_EXC_PARSE_EXCEPTION_HPP_

#include "LlvmException.hpp"

namespace ltf
{
    // Indicates an error that occurred while parsing the LLVM input.
    class ParseException : public LlvmException
    {
    public:
        ParseException(const std::string& llvmMessage) throw()
            : LlvmException(format(llvmMessage)) { }
        virtual ~ParseException() throw() { }
    
    private:
        static std::string format(const std::string& llvmMessage);
    };
}

#endif // LTF_EXC_PARSE_EXCEPTION_HPP_
