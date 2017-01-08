#include "FirmHandle.hpp"
#include "../Util/Logging.hpp"

namespace ltf
{
    FirmHandle::FirmHandle(const firm_parameter_t *params)
    {
        log::info << "Initializing firm" << log::end;
        ir_init(params);
    }

    FirmHandle::~FirmHandle()
    {
        log::info << "Cleaning up firm" << log::end;
        ir_finish();
    }
}
