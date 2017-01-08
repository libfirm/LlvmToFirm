#ifndef LTF_UTIL_STRING_TOOLS_HPP_
#define LTF_UTIL_STRING_TOOLS_HPP_

#include <string>
#include <algorithm>

namespace ltf
{
    namespace str
    {
        inline void remove(std::string& str, char search)
        {
            // Erase-remove idiom.
            str.erase(
                std::remove(str.begin(), str.end(), search),
                str.end()
            );
        }
        
        inline void replace(std::string& str, char search, char replacement)
        {
            std::replace(str.begin(), str.end(), search, replacement);
        }
        
        inline void shorten(std::string& str, std::size_t length)
        {
            // Determine the number of dots to append.
            std::size_t numDots = 2;
            if (length < numDots) numDots = length;
            length -= numDots;
            
            str.erase(length);
            str.append(std::string(numDots, '.'));
        }
        
        // Enclose string in quotation marks, if spaces are present.
        inline std::string quote(const std::string& str)
        {
            if (str.find(' ') == std::string::npos) return str;
            return std::string("\"") + str + std::string("\"");
        }
        
        // Change the file extension, under the assumption, that str is a
        // filename. Appends an extention, if none is currently present.
        inline std::string changeFileExt(const std::string& str,
            const std::string& ext)
        {
            std::size_t index = str.find_last_of('.');
            if (index == std::string::npos) index = str.length();
            
            return str.substr(0, index) + std::string(".") + ext;
        }
        
        // Checks if str begins with prefix.
        inline bool beginsWith(const std::string& str, const std::string& prefix)
        {
            if (str.length() < prefix.length()) return false;
            
            for (unsigned int i = 0; i < prefix.length(); i++)
            {
                if (str[i] != prefix[i]) return false;
            }
            
            return true;
        }
        
        // Checks if str ends with suffix.
        inline bool endsWith(const std::string& str, const std::string& suffix)
        {
            if (str.length() < suffix.length()) return false;
            
            for (unsigned int i = 0; i < suffix.length(); i++)
            {
                if (str[str.length() - suffix.length() + i] !=
                    suffix[i]) return false;
            }
            
            return true;
        }
    }
}

#endif /* LTF_UTIL_STRING_TOOLS_HPP_ */
