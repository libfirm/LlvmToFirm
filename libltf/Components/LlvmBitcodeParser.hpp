#ifndef LTF_CMP_LLVM_BITCODE_PARSER_HPP_
#define LTF_CMP_LLVM_BITCODE_PARSER_HPP_

#include "../Facade/Parser.hpp"

namespace ltf
{
    class LlvmBitcodeParser : public Parser
    {
    public:
        ModuleSPtr run(const std::string& filename);
    };
}

#endif /* LTF_CMP_LLVM_BITCODE_PARSER_HPP_ */
