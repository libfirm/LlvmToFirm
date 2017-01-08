#include "UnoptimizedScope.hpp"
#include <libfirm/firm.h>

namespace ltf
{
    UnoptimizedScope::UnoptimizedScope()
        : oldSetting(get_optimize())
    {
        set_optimize(false);
    }

    UnoptimizedScope::~UnoptimizedScope()
    {
        set_optimize(oldSetting);
    }
}
