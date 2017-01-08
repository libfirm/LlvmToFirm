#include "../Builders/NodeBuilder.hpp"

#include <queue>
#include <vector>
#include <cassert>
#include <functional>
#include <llvm/Value.h>
#include <llvm/Constants.h>
#include <llvm/BasicBlock.h>
#include <llvm/Instructions.h>
#include <libfirm/firm.h>
#include "../Builders/BlockBuilder.hpp"
#include "../Builders/TypeBuilder.hpp"
#include "../RAII/BlockScope.hpp"
#include "../Util/Logging.hpp"
#include "../Util/Casting.hpp"
#include "../Util/TypeInfo.hpp"
#include "../Exceptions/NotSupportedException.hpp"
#include "../Exceptions/NotImplementedException.hpp"

// This is similar to what lower_switch.c in firm does, but it supports switch
// with wider bit widths, than firm, which is required, to properly support
// LLVMs switch statement.
// Basically it creates some kind of binary search using if-statements, to
// figure out which case statement equals the given condition value.

namespace
{
    struct CaseRange
    {
        CaseRange(ir_node* block, int index, int count)
            : block(block), index(index), count(count) { }
        
        ir_node* block;
        int index, count;
    };
    
    struct SwitchCase
    {
        int index;
        ir_node* valueNode;
        const llvm::ConstantInt* value;
        const llvm::BasicBlock* target;
    };
    
    // Signed lesser than functor for cases.
    struct SwitchCaseLess : std::binary_function<SwitchCase, SwitchCase, bool>
    {
        bool operator()(SwitchCase a, SwitchCase b)
        {
            return a.value->getValue().slt(b.value->getValue());
        }
    };
}
   
namespace ltf
{
    /* ====================================================================== */
    /* =                             If Cascade                             = */
    /* ====================================================================== */
    
    // [int-atom]
    ir_node* NodeBuilder::buildIfCascade(const llvm::SwitchInst* inst)
    {
        const llvm::BasicBlock* block        = inst->getParent();
        const llvm::BasicBlock* defaultBlock = inst->getDefaultDest();
        const llvm::Value*      switchValue  = inst->getCondition();
        
        if (!ti::isIntAtom(switchValue->getType()))
        {
            throw NotSupportedException("Non-int-atomic if-cascade");
        }
        
        // Get the empty switch out of the way first.
        if (inst->getNumCases() <= 1)
        {
            log::debug << "Empty switch found" << log::end;
            
            ir_node* jmpNode = new_Jmp();
            blockBuilder->registerJump(block, defaultBlock, jmpNode);
            set_cur_block(new_Bad());
            return 0;
        }
        
        // Get a signed and normalized value.
        ir_node* switchNode = retrieve(switchValue);
        switchNode = ac::intToSBase(switchValue->getType(), switchNode);
        
        // Collect the indices of all cases.
        typedef std::vector<SwitchCase> CaseList;
        CaseList cases;
        cases.reserve(inst->getNumCases());
        
        for (unsigned int i = 1; i < inst->getNumCases(); i++)
        {
            SwitchCase switchCase; // Constants are always normalized.
            switchCase.valueNode = retrieve(inst->getCaseValue(i));
            switchCase.value     = inst->getCaseValue(i);
            switchCase.target    = inst->getSuccessor(i);
            switchCase.index     = i - 1;
            cases.push_back(switchCase);
        }
        
        // And sort them by their case values.
        std::sort(cases.begin(), cases.end(), SwitchCaseLess());
        
        // Begin with the full range.
        typedef std::queue<CaseRange> RangeQueue;
        RangeQueue ranges;
        ranges.push(CaseRange(get_cur_block(), 0, cases.size()));
        
        // This will restore the block later.
        BlockScope scope;
        log::debug << "Building if-cascade for switch" << log::end;
        
        // Create a default block up-front and always leave using this block
        // for default cases. Having multiple return paths would mess up phi
        // nodes, so leave some blocks for control flow optimization later.
        ir_node* defaultBlockNode = new_immBlock();
        set_cur_block(defaultBlockNode);
        
        ir_node* defaultJmpNode = new_Jmp();
        blockBuilder->registerJump(block, defaultBlock, defaultJmpNode);
        blockBuilder->redirectPhi(get_cur_block(), scope.getBlock());
        set_cur_block(new_Bad());
        
        while (!ranges.empty())
        {
            // Get the next range to process, set its block.
            CaseRange range = ranges.front();
            ranges.pop();
            set_cur_block(range.block);

            if (range.count == 0) // else
            {
                // Jump to the default block.
                ir_node* jmpNode = new_Jmp();
                add_immBlock_pred(defaultBlockNode, jmpNode);
                set_cur_block(new_Bad());
            }
            else if (range.count <= 2) // if(eq)/else and if(eq)/if(eq)/else.
            {
                SwitchCase first = cases[range.index];

                // Create an equality comparison.
                ir_node* cmpNode    = new_Cmp(switchNode, first.valueNode);
                ir_node* eqProjNode = new_Proj(cmpNode, mode_b, pn_Cmp_Eq);
                ir_node* condNode   = new_Cond(eqProjNode);
                
                ir_node* trueProjNode  = new_Proj(condNode, mode_X, pn_Cond_true);
                ir_node* falseProjNode = new_Proj(condNode, mode_X, pn_Cond_false);
                
                // Register the jump.
                blockBuilder->registerJump(block, first.target, trueProjNode);
                blockBuilder->redirectPhi(get_cur_block(), scope.getBlock());
                
                // Reschedule the other part. It will either create a jump to
                // the default case or comes back here for an if-if-else.
                ir_node* nodes[1] = { falseProjNode };
                ir_node* falseBlock = new_Block(1, nodes);
                
                ranges.push(CaseRange(falseBlock, range.index + 1, range.count - 1));
                set_cur_block(new_Bad());
                
            }
            else // if(lt)/else
            {
                // The lower range excludes the pivot.
                
                // 0 1 2 3 4 5 6 --> count      = 7
                // . . . P . . . --> pivotIndex = 3
                // L L L U U U U --> lowerCount = 3, upperCount = 4
                
                int pivotIndex   = range.index + range.count / 2;
                int lowerCount   = range.count / 2;
                int upperCount   = range.count - lowerCount;
                SwitchCase pivot = cases[pivotIndex];

                // Create a lesser-than comparison with the pivot.
                ir_node* cmpNode    = new_Cmp(switchNode, pivot.valueNode);
                ir_node* eqProjNode = new_Proj(cmpNode, mode_b, pn_Cmp_Lt);
                ir_node* condNode   = new_Cond(eqProjNode);
                
                ir_node* trueProjNode  = new_Proj(condNode, mode_X, pn_Cond_true);
                ir_node* falseProjNode = new_Proj(condNode, mode_X, pn_Cond_false);
                
                // Split into two smaller parts.
                ir_node* trueNodes[1]  = { trueProjNode  };
                ir_node* falseNodes[1] = { falseProjNode };
                ir_node* trueBlock  = new_Block(1, trueNodes);
                ir_node* falseBlock = new_Block(1, falseNodes);
                
                // Push the ranges to the work queue.
                ranges.push(CaseRange(trueBlock,  range.index, lowerCount));
                ranges.push(CaseRange(falseBlock, pivotIndex,  upperCount));
                set_cur_block(new_Bad());
            }
        }

        // Mature the default case block.
        mature_immBlock(defaultBlockNode);
        return 0;
    }
}
