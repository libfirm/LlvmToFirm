#include "FileHandle.hpp"
#include <stdexcept>

FileHandle::FileHandle(const std::string& filename, const std::string& mode)
{
    handle = fopen(filename.c_str(), mode.c_str());
    if (handle == 0) throw std::runtime_error("Couldn't open the given file");
}

FileHandle::~FileHandle()
{
    fclose(handle);
}
