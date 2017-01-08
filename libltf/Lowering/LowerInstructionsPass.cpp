#include "LowerInstructionsPass.hpp"

#include <vector>
#include <cassert>
#include <llvm/Module.h>
#include <llvm/Function.h>
#include <llvm/BasicBlock.h>
#include <llvm/Instructions.h>
#include <llvm/Support/Casting.h>
#include "../Util/Logging.hpp"
using llvm::cast;

namespace ltf
{
    char LowerInstructionsPass::ID = 0;
    
    void LowerInstructionsPass::getAnalysisUsage(llvm::AnalysisUsage& usage) const
    {
        // We don't modify blocks or terminator instructions.
        usage.setPreservesCFG();
    }
    
    bool LowerInstructionsPass::runOnBasicBlock(llvm::BasicBlock& block)
    {
        bool hasChanged = false;
        module = block.getParent()->getParent();
        
        for (llvm::BasicBlock::iterator it = block.begin(),
            eit = block.end(); it != eit; ++it)
        {
            bool doRemove = false;
            
            // Call the appropriate lowering method.
            switch (it->getOpcode())
            {
            case llvm::Instruction::FRem:
                doRemove |= lowerFRem(cast<llvm::BinaryOperator>(it));
                break;
            }
            
            // Remove the current instruction if instructed to do so.
            if (doRemove)
            {
                hasChanged = true;
                it = --block.getInstList().erase(it);
            }
        }
        
        return hasChanged;
    }
    
    bool LowerInstructionsPass::lowerFRem(llvm::BinaryOperator* valueOp)
    {
        assert(valueOp != 0);

        log::debug << "Lowering frem instruction" << log::end;
        
        std::string functionName;
        switch (valueOp->getType()->getTypeID())
        {
        case llvm::Type::FloatTyID:    functionName = "fmodf"; break;
        case llvm::Type::DoubleTyID:   functionName = "fmod";  break;
        case llvm::Type::X86_FP80TyID: functionName = "fmodl"; break;
        
        // Skip it. This will most probably stop later.
        default: return false;
        }
        
        // Create an appropriate function.
        llvm::Constant* function = module->getOrInsertFunction(
            functionName, valueOp->getType(),
            valueOp->getType(), valueOp->getType(), NULL
        );
        
        // Create a call wiht the appropriate operands.
        std::vector<llvm::Value*> arguments;
        arguments.push_back(valueOp->getOperand(0));
        arguments.push_back(valueOp->getOperand(1));
        
        llvm::CallInst* callInstruction = llvm::CallInst::Create(
            function, arguments.begin(), arguments.end(), "", valueOp
        );
        
        // Replace the operator.
        valueOp->replaceAllUsesWith(callInstruction);
        return true;
    }
}
