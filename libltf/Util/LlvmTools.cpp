#include "LlvmTools.hpp"

#include <cstdlib>
#include <cassert>
#include <llvm/ADT/APInt.h>
#include <llvm/ADT/APFloat.h>
#include <llvm/DerivedTypes.h>
#include <llvm/Support/Casting.h>
#include <libfirm/firm.h>
#include "../Util/Logging.hpp"
#include "../Exceptions/NotSupportedException.hpp"
using llvm::isa;
using llvm::cast;
using llvm::dyn_cast;

namespace ltf
{
    namespace lt
    {
        // Using strings for conversion might not be the fastest way, but it has
        // a number of advantages: a string can be infinitely precise and there
        // are no datatype or endianess issues (for example using a long could
        // lead to data loss on 64 bit integers, depending on the platform).
        // Conversion speed is also compensated by constant caching.
        
        tarval* getTarvalFromInteger(const llvm::APInt& value, ir_mode* mode)
        {
            // Our firm integers are always signed. Note that firm seems to be
            // smarter for integer values and stores them in a buffer of the
            // appropriate size, instead of using an unportable type like long
            // double. So stay clear of new_tarval_from_long and things should
            // be okay (hopefully).
            std::string str = value.toString(10, true);
            return new_tarval_from_str(str.c_str(), str.length(), mode);
        }
        
        tarval* getTarvalFromFloat(const llvm::APFloat& value, ir_mode* mode)
        {
            // Handle special values first.
            if (value.isNaN())
            {
                // Not a number.
                return get_tarval_nan(mode);
            }
            else if (value.isInfinity())
            {
                // Positive and negative infinity.
                if (value.isNegative())
                {
                    return get_tarval_minus_inf(mode);
                }
                else
                {
                    return get_tarval_plus_inf(mode);
                }
            }
                       
            // 128 Bit worst case. That's 32 chars for exponent and significand,
            // plus 3 chars: ('+'|'-'), '.' and 'p'. So it's about 35 chars at
            // worst, making a 128 char buffer more than sufficient. 
            char buffer[128];
            
            // Note that the rounding mode isn't even used, if hexDigits is 0.
            unsigned int length = value.convertToHexString(buffer, 0,
                false, llvm::APFloat::rmNearestTiesToEven);
            assert((length < 128) && "Unexpected buffer overflow");

            // Strtold is able to read the C99 floating point format. Alas, it
            // is C99 itself, so it's not as portable as it should be. The same
            // applies for long double itself (MSVC for example turns this into
            // a double). It works as long as the current platform supports the
            // correct long double type. This makes it impossible, to maintain
            // full precision when cross-compiling on a machine that doesn't
            // support the target machines long double.
            // This is actually a firm problem, because it also stores the value
            // as long double in memory.
            long double valueFloat = strtold(buffer, 0);
            return new_tarval_from_double(valueFloat, mode);
        }
    }
}
