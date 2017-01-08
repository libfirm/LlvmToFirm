#ifndef LTF_UTIL_LLVM_TOOLS_HPP_
#define LTF_UTIL_LLVM_TOOLS_HPP_

#include <vector>
#include <libfirm/firm_types.h>

namespace llvm
{
    class Type;
    class APInt;
    class APFloat;
    class CompositeType;
}

namespace ltf
{
    namespace lt
    {
        tarval* getTarvalFromInteger(const llvm::APInt& value, ir_mode* mode);
        tarval* getTarvalFromFloat(const llvm::APFloat& value, ir_mode* mode);
    }
}

#endif /* LTF_UTIL_LLVM_TOOLS_HPP_ */
