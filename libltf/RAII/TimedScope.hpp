#ifndef LTF_RAII_TIMED_SCOPE_HPP_
#define LTF_RAII_TIMED_SCOPE_HPP_

#include <string>
#include <sys/time.h>
#include <boost/utility.hpp>
#include "../Util/Logging.hpp"

namespace ltf
{
    // XXX: platform dependend code
    class TimedScope : boost::noncopyable
    {
    public:
        TimedScope(const std::string& blockName, log::LogStream& stream = log::info)
            : stream(stream), blockName(blockName), isStopped(false)
        {
            gettimeofday(&startTime, 0);
        }
        
        ~TimedScope()
        {
            if (isStopped) return;
            logTime();
        }
        
        void stop()
        {
            if (isStopped) return;
            
            logTime();
            isStopped = true;
        }
        
        void next(const std::string& blockName)
        {
            if (!isStopped) logTime();
            
            this->blockName = blockName;
            gettimeofday(&startTime, 0);
            isStopped = false;
        }
        
    private:
        log::LogStream& stream;
        std::string blockName;
        timeval startTime;
        bool isStopped;
        
        void logTime()
        {
            timeval endTime;
            gettimeofday(&endTime, 0);
            
            double startTimeMsec = startTime.tv_sec * 1E3 + startTime.tv_usec / 1E3;
            double endTimeMsec   = endTime.tv_sec   * 1E3 + endTime.tv_usec   / 1E3;
            double diffMsec = endTimeMsec - startTimeMsec;
            
            stream << blockName << " took " << diffMsec << " ms" << log::end;
        }
    };
}

#endif /* LTF_RAII_TIMED_SCOPE_HPP_ */
