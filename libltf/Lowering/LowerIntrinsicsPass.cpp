#include "LowerIntrinsicsPass.hpp"

#include <cassert>
#include <boost/foreach.hpp>
#include <llvm/Module.h>
#include <llvm/Function.h>
#include <llvm/Instructions.h>
#include <llvm/Support/Casting.h>
#include <llvm/Target/TargetData.h>
#include <llvm/CodeGen/IntrinsicLowering.h>
#include "../Util/Logging.hpp"
using llvm::dyn_cast;

namespace ltf
{
    char LowerIntrinsicsPass::ID = 0;
    
    void LowerIntrinsicsPass::getAnalysisUsage(llvm::AnalysisUsage& usage) const
    {
        // We don't modify blocks or terminator instructions.
        usage.setPreservesCFG();
        usage.addRequired<llvm::TargetData>();
    }

    bool LowerIntrinsicsPass::runOnModule(llvm::Module& module)
    {
        bool hasChanged = false;

        // Collect instructions to lower first.
        std::vector<llvm::CallInst*> intrinsicCalls;
        
        BOOST_FOREACH (llvm::Function& function, module.getFunctionList())
        {
            if (function.isDeclaration()) continue;
            
            BOOST_FOREACH (llvm::BasicBlock& block, function.getBasicBlockList())
            {
                BOOST_FOREACH (llvm::Instruction& instruction, block.getInstList())
                {
                    llvm::CallInst* callInstruction =
                        dyn_cast<llvm::CallInst>(&instruction);
                    
                    // Find lowerable intrinsic calls.
                    if (canBeLowered(callInstruction))
                    {
                        intrinsicCalls.push_back(callInstruction);
                    }
                }
            }
        }
        
        // Create an intrinsic lowering object.
        llvm::TargetData& targetData = getAnalysis<llvm::TargetData>();
        llvm::IntrinsicLowering intrinsicLowering(targetData);
        
        // Lower intrinsic calls.
        BOOST_FOREACH (llvm::CallInst* instruction, intrinsicCalls)
        {
            llvm::Intrinsic::ID intrinsicId = static_cast<llvm::Intrinsic::ID>(
                instruction->getCalledFunction()->getIntrinsicID()
            );

            log::debug << "Lowering " << llvm::Intrinsic::getName(
                intrinsicId) << " intrinsic" << log::end;
            
            // Actually lower the call.
            intrinsicLowering.LowerIntrinsicCall(instruction);
            
            hasChanged = true;
        }
        
        return hasChanged;
    }
    
    bool LowerIntrinsicsPass::canBeLowered(llvm::CallInst* instruction)
    {
        if (instruction == 0) return false;
        const llvm::Function* calledFunction = instruction->getCalledFunction();
        
        // Only process calls to intrinsics.
        if ((calledFunction == 0) || !calledFunction->isIntrinsic()) return false;
        
        // These are basically all calls that the IntrinsicLowering object can
        // lower and that are not directly supported.
        switch (calledFunction->getIntrinsicID())
        {
        // Lower intrinsics to function calls.
        case llvm::Intrinsic::memcpy:  return true;
        case llvm::Intrinsic::memset:  return true;
        case llvm::Intrinsic::memmove: return true;
        case llvm::Intrinsic::sqrt:    return true;
        case llvm::Intrinsic::sin:     return true;
        case llvm::Intrinsic::cos:     return true;
        case llvm::Intrinsic::pow:     return true;
        case llvm::Intrinsic::log:     return true;
        case llvm::Intrinsic::log2:    return true;
        case llvm::Intrinsic::log10:   return true;
        case llvm::Intrinsic::exp:     return true;
        case llvm::Intrinsic::exp2:    return true;
        
        // [TODO] Check, which could be done directly in firm.
        case llvm::Intrinsic::ctpop:   return true;
        case llvm::Intrinsic::bswap:   return true;
        case llvm::Intrinsic::ctlz:    return true;
        case llvm::Intrinsic::cttz:    return true;
        
        // According to IntrinsicLowering.cpp, these should only
        // appear in totally unoptimized code. Make sure to get rid
        // off them in any case.
        case llvm::Intrinsic::setjmp:     return true;
        case llvm::Intrinsic::longjmp:    return true;
        case llvm::Intrinsic::siglongjmp: return true;
        }
        
        return false;
    }
}
