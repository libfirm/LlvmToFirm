#ifndef LTF_FACADE_PARSER_HPP_
#define LTF_FACADE_PARSER_HPP_

#include <string>
#include "../Typedef/Pointer.hpp"

namespace ltf
{
    class Parser
    {
    public:
        // Read the given file and produce a LLVM module.
        virtual ModuleSPtr run(const std::string& filename) = 0;
    };
}

#endif /* LTF_FACADE_PARSER_HPP_ */
