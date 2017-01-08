#ifndef LTF_LOWERING_LOWER_INSTRUCTIONS_PASS_HPP_
#define LTF_LOWERING_LOWER_INSTRUCTIONS_PASS_HPP_

#include <llvm/Pass.h>

namespace llvm
{
    class BinaryOperator;
    class InsertValueInst;
    class ExtractValueInst;
}

namespace ltf
{
    class LowerInstructionsPass : public llvm::BasicBlockPass
    {
    public:
        static char ID;
        LowerInstructionsPass() : BasicBlockPass(&ID) { }
        
        void getAnalysisUsage(llvm::AnalysisUsage& usage) const;
        bool runOnBasicBlock(llvm::BasicBlock& block);
        
    private:
        bool lowerFRem(llvm::BinaryOperator* valueOp);

        llvm::Module* module;
    };
}

#endif /* LTF_LOWERING_LOWER_INSTRUCTIONS_PASS_HPP_ */
