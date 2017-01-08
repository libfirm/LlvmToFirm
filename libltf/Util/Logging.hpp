#ifndef LTF_UTIL_LOGGING_HPP_
#define LTF_UTIL_LOGGING_HPP_

#include <iostream>
#include <sstream>
#include <streambuf>
#include <boost/utility.hpp>
#include "../Typedef/Pointer.hpp"

namespace ltf
{
    namespace log
    {
        struct LogLevel
        {
            enum Enum
            {
                Lowest  = 0,
                Error   = 0,
                Warning = 1,
                Info    = 2,
                Debug   = 3,
                Highest = 3
            };
        };
        
        // Interface for loggers.
        class Logger
        {
        public:
            virtual void logMessage(LogLevel::Enum logLevel,
                const std::string& message) = 0;
        };
        
        // Get or set the currently used logger.
        LoggerSPtr getLogger();
        void setLogger(LoggerSPtr logger);
        
        // Get or set the minimal reported severity.
        LogLevel::Enum getLogLevel();
        void setLogLevel(LogLevel::Enum severity);

        // Stream buffer that collects log messages in a string.
        class LogBuffer : public std::basic_streambuf
            < char, std::char_traits<char> >, boost::noncopyable
        {
        private:
            typedef std::char_traits<char> traits;
            
            // Inner storage.
            std::string buffer;
            LogLevel::Enum logLevel;
            
        public:
            LogBuffer(LogLevel::Enum logLevel)
                : logLevel(logLevel) { }
            
            ~LogBuffer()
            {
                sync();
            }
            
            void endMessage()
            {
                sync();
            }
            
        protected:
            // A new character is being inserted on a full buffer. int_type
            // can have special values, such as eof and may not be char.
            traits::int_type overflow(traits::int_type chr)
            {
                if (logLevel > getLogLevel())
                {
                    // Silently swallow chars that exceed the maximum log level.
                    return traits::not_eof(chr);
                }
                
                // Check that the character is not eof.
                if (!traits::eq_int_type(chr, traits::eof()))
                {
                    // Turn the int_type into the char type and append it to
                    // the internal buffer.
                    buffer += traits::to_char_type(chr);
                }
                
                // Return something else than eof, to signal success.
                return traits::not_eof(chr);
            }
            
            int sync()
            {
                if (!buffer.empty())
                {
                    // Pass the data to the current logger.
                    if (getLogger().get() != 0)
                    {
                        getLogger()->logMessage(logLevel, buffer);
                    }
                    
                    buffer.clear();
                }

                return 0; // Success
            }
        };
        
        // Output stream with a LogBuffer.
        class LogStream : public std::basic_ostream
            < char, std::char_traits<char> >, boost::noncopyable
        {
        private:
            typedef std::basic_ostream< char, std::char_traits<char> > Base;
            LogBuffer logBuffer;
            
        public:
            LogStream(LogLevel::Enum logLevel)
                : Base(&logBuffer), logBuffer(logLevel)
            { }
            
            void endMessage()
            {
                logBuffer.endMessage();
            }
        };
        
        // The default console logger.
        class ConsoleLogger : public Logger
        {
        public:
            void logMessage(LogLevel::Enum logLevel,
                const std::string& message);
        };
        
        // end instead of std::endl allows messages with newlines.
        inline std::ostream& end(std::ostream& os)
        {
            static_cast<LogStream&>(os).endMessage();
            return os;
        }
        
        // Define the default streams.
        static LogStream debug   (LogLevel::Debug);
        static LogStream info    (LogLevel::Info);
        static LogStream warning (LogLevel::Warning);
        static LogStream error   (LogLevel::Error);
    }
}

#endif /* LTF_UTIL_LOGGING_HPP_ */
