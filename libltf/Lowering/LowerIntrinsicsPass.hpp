#ifndef LTF_LOWERING_LOWER_INTRINSICS_PASS_HPP_
#define LTF_LOWERING_LOWER_INTRINSICS_PASS_HPP_

#include <llvm/Pass.h>

namespace llvm
{
    class CallInst;
}

namespace ltf
{
    // BasicBlockPass or FunctionPass are not allowed, to modify the module,
    // but IntrinsicLowering will insert function declarations. 
    class LowerIntrinsicsPass : public llvm::ModulePass
    {
    public:
        static char ID;
        LowerIntrinsicsPass() : ModulePass(&ID) { }
        
        void getAnalysisUsage(llvm::AnalysisUsage& usage) const;
        bool runOnModule(llvm::Module& module);
        
    private:
        bool canBeLowered(llvm::CallInst* instruction);
    };
}

#endif /* LTF_LOWERING_LOWER_INTRINSICS_PASS_HPP_ */
