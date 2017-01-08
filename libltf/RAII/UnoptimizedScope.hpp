#ifndef LTF_RAII_UNOPTIMIZED_SCOPE_HPP_
#define LTF_RAII_UNOPTIMIZED_SCOPE_HPP_

#include <boost/utility.hpp>

namespace ltf
{
    class UnoptimizedScope : boost::noncopyable
    {
    public:
        UnoptimizedScope();
        ~UnoptimizedScope();
        
    private:
        int oldSetting;
    };
}

#endif /* LTF_RAII_UNOPTIMIZED_SCOPE_HPP_ */
