#include "VerifyException.hpp"
#include <sstream>

namespace ltf
{
    std::string VerifyException::format(const std::string& llvmMessage)
    {
        std::ostringstream messageStream;
        messageStream << "Verify error: " << llvmMessage;
        return messageStream.str();
    }
}
