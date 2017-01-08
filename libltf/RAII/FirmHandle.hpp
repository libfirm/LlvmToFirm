#ifndef LTF_RAII_FIRM_HANDLE_HPP_
#define LTF_RAII_FIRM_HANDLE_HPP_

#include <boost/utility.hpp>
#include <libfirm/firm.h>

namespace ltf
{
    // TODO: define useful copy semantics
    // RAII wrapper for firm, to ensure proper cleanup.
    class FirmHandle : boost::noncopyable
    {
    public:
        FirmHandle(const firm_parameter_t *params);
        ~FirmHandle();
    };
}

#endif // LTF_RAII_FIRM_HANDLE_HPP_
