#include "NotImplementedException.hpp"
#include <sstream>

namespace ltf
{
    std::string NotImplementedException::format(const std::string& message)
    {
        std::ostringstream messageStream;
        messageStream << "Not implemented: " << message;
        return messageStream.str();
    }
}
