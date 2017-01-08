#include "Logging.hpp"

#include <iostream>
using namespace boost;

namespace ltf
{
    namespace log
    {
        void ConsoleLogger::logMessage(LogLevel::Enum logLevel,
            const std::string& message)
        {
            switch (logLevel)
            {
            case LogLevel::Debug:
                std::cout << "Debug: " << message << std::endl;
                break;
                
            case LogLevel::Info:
                std::cout << "Info:  " << message << std::endl;
                break;
                            
            case LogLevel::Warning:
                std::cout << "Warn:  " << message << std::endl;
                break;
                            
            case LogLevel::Error:
                std::cerr << "ERROR: " << message << std::endl;
                break;
            }
            
        }
        
        namespace
        {
            // Set the default logger and log level.
            LoggerSPtr logger = LoggerSPtr(new ConsoleLogger());
            LogLevel::Enum logLevel = LogLevel::Warning;
        }

        LoggerSPtr getLogger()
        {
            return logger;
        }

        void setLogger(LoggerSPtr logger)
        {
            ltf::log::logger = logger;
        }
        
        LogLevel::Enum getLogLevel()
        {
            return logLevel;
        }
        
        void setLogLevel(LogLevel::Enum logLevel)
        {
            ltf::log::logLevel = logLevel;
        }
    }
}
