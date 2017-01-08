#include "ParseException.hpp"
#include <sstream>

namespace ltf
{
    std::string ParseException::format(const std::string& llvmMessage)
    {
        std::ostringstream messageStream;
        messageStream << "Parse error: " << llvmMessage;
        return messageStream.str();
    }
}
