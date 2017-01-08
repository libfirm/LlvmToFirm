#include "NotSupportedException.hpp"
#include <sstream>

namespace ltf
{
    std::string NotSupportedException::format(const std::string& message)
    {
        std::ostringstream messageStream;
        messageStream << "Not supported: " << message;
        return messageStream.str();
    }
}
