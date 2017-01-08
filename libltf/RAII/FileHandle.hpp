#ifndef LTF_RAII_FILE_HANDLE_HPP_
#define LTF_RAII_FILE_HANDLE_HPP_

#include <stdio.h>
#include <boost/utility.hpp>

namespace ltf
{
    class FileHandle : boost::noncopyable
    {
    private:
        FILE* handle;
        
    public:
        FileHandle(const std::string& filename, const std::string& mode);
        ~FileHandle();
        
        FILE* get()
        {
            return handle;
        }
    };
}

#endif /* LTF_RAII_FILE_HANDLE_HPP_ */
