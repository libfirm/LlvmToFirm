#ifndef FILE_HANDLE_HPP_
#define FILE_HANDLE_HPP_

#include <stdio.h>
#include <boost/utility.hpp>

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

#endif /* FILE_HANDLE_HPP_ */
