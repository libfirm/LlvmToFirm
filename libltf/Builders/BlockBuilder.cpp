#include "BlockBuilder.hpp"

#include <cassert>
#include <iterator>
#include <algorithm>
#include <boost/foreach.hpp>
#include <boost/unordered_set.hpp>
#include <llvm/Support/CFG.h>
#include <llvm/BasicBlock.h>
#include <libfirm/firm.h>
#include "../Util/Logging.hpp"
#include "../Util/FirmTools.hpp"
#include "../Util/MapTools.hpp"
using namespace boost;
using llvm::pred_begin;
using llvm::pred_end;

namespace ltf
{
    BlockBuilder::BlockBuilder(Context& context, ir_graph* graph)
        : context(context), graph(graph)
    {
        assert(graph != 0);
    }
    
    void BlockBuilder::registerEntryBlock(const llvm::BasicBlock* block,
        ir_node* fBlock)
    {
        assert((block != 0) && (fBlock != 0));
        log::debug << "Registering entry block \"" <<
            block->getNameStr() << "\"" << log::end;

        // Store in the cache, as building would do.
        assert(refCounts.empty() && "Entry block not registered first");
        cacheInsert(block, fBlock);
        initReferenceCount(block);
        
        fEntryBlock = fBlock;
    }
    
    ir_node* BlockBuilder::getEntryBlock()
    {
        assert((fEntryBlock != 0) && "Entry block not registered");
        return fEntryBlock;
    }

    void BlockBuilder::registerJump(const llvm::BasicBlock* srcBlock,
        const llvm::BasicBlock* dstBlock, ir_node* predNode)
    {
        // Determine the source block in firm.
        ir_node* fSrcBlock = get_cur_block();

        // Print some nice debug info.
        log::debug << "Adding jump from \"" << srcBlock->getNameStr() << "\"";
        if (dstBlock == 0) log::debug << " (return)";
        else
        {
            log::debug << " to \"" << dstBlock->getNameStr() << "\"";
            if (predNode == 0) log::debug << " (no-op)";
        }
        log::debug << log::end;
        
        // Okay every block should call this some time. They tell us the
        // terminator node (if there is one) and the target block, so we can
        // update the target blocks reference count and keep track of the
        // blocks last memory store. We also connect the jump and target block
        // to make things easier for the caller.
        
        if (predNode != 0)
        {
            // Add the jump as predecessor of the given block.
            ir_node* fDstBlock = 0;
            
            // Block 0 specifies the end block.
            if (dstBlock != 0) fDstBlock = lookup(dstBlock);
            else               fDstBlock = get_irg_end_block(graph);
            
            add_immBlock_pred(fDstBlock, predNode);
    
            // Lower the targets reference count by one.
            if (dstBlock != 0) lowerReferenceCount(dstBlock);
        }

        // Save the current memory node, to possibly keep it alive later.
        blockMemories[fSrcBlock] = get_store();
    }
    
    void BlockBuilder::redirectPhi(ir_node* srcBlock, ir_node* dstBlock)
    {
        if (srcBlock == dstBlock) return;
        phiRedirects[srcBlock].insert(dstBlock);
    }

    /* ====================================================================== */
    /* =                         Build entry point                          = */
    /* ====================================================================== */
    
    ir_node* BlockBuilder::doBuild(const llvm::BasicBlock* block, bool& doCache)
    {
        // Ensure that the correct graph is set.
        set_current_ir_graph(graph);
        
        log::debug << "Building block \"" << block->getNameStr() <<
            "\"" << log::end;
        
        ir_node* blockNode = new_immBlock();
        initReferenceCount(block);
        return blockNode;
    }
    
    void BlockBuilder::clearCache()
    {
        Base::clearCache();
        refCounts.clear();
        blockMemories.clear();
        phiRedirects.clear();
    }
    
    /* ====================================================================== */
    /* =                         Reference counting                         = */
    /* ====================================================================== */
    
    void BlockBuilder::initReferenceCount(const llvm::BasicBlock* block)
    {
        // Get the number of predecessors.
        llvm::pred_const_iterator beginIt   = pred_begin (block);
        llvm::pred_const_iterator endIt     = pred_end   (block);
        unsigned int              predCount = std::distance(beginIt, endIt);
        
        // Default reference count is 1 (for instruction construction), plus
        // the number of predecessors to the block, that have to be added
        // before maturing.
        unsigned int refCount = predCount + 1;
        refCounts.insert(BlockIntPair(block, refCount));
        log::debug << "Initial reference count " << refCount << log::end;
    }
    
    void BlockBuilder::lowerReferenceCount(const llvm::BasicBlock* block, int amount)
    {
        assert((amount > 0) && (block != 0));
        
        // Fetch the reference count.
        BlockToIntMapIt refCountIt = refCounts.find(block);
        assert((refCountIt != refCounts.end()) && "Missing block");
        
        // Update the reference count.
        int& refCount = (*refCountIt).second;
        refCount -= amount;
        assert((refCount >= 0) && "Negative reference count");
        
        // Mature the block, when zero is reached.
        if (refCount <= 0)
        {
            matureBlock(block);
            refCounts.erase(refCountIt);
        }
    }
    
    void BlockBuilder::raiseReferenceCount(const llvm::BasicBlock* block, int amount)
    {
        assert((amount > 0) && (block != 0));
        
        // Fetch the reference count.
        BlockToIntMapIt refCountIt = refCounts.find(block);
        assert((refCountIt != refCounts.end()) && "Missing block");
        
        // Update the reference count.
        int& refCount = (*refCountIt).second;
        refCount += amount;
    }
    
    /* ====================================================================== */
    /* =                           Block maturing                           = */
    /* ====================================================================== */

    void BlockBuilder::matureRemainingBlocks()
    {
        if (refCounts.empty()) return;
        log::debug << "Maturing remaining blocks" << log::end;
        
        BOOST_FOREACH (const BlockIntPair& entry, refCounts)
        {
            assert((entry.second > 0) && "Block with reference count <= 0");
            matureBlock(entry.first);
        }
        
        refCounts.clear();
    }

    void BlockBuilder::matureBlock(const llvm::BasicBlock* block)
    {
        assert(block != 0);
        
        ir_node* fBlock = lookup(block);
        assert((fBlock != 0) && "Missing block");
        
        mature_immBlock(fBlock);
        log::debug << "Maturing block \"" << block->getNameStr() << "\"" << log::end;
    }
    
    /* ====================================================================== */
    /* =                         Keep blocks alive                          = */
    /* ====================================================================== */
    
    void BlockBuilder::keepBlocksAlive()
    {
        // Iterate the cached blocks and make sure each has a terminator.
        for (CacheMapCIt it = cacheBegin(), eit = cacheEnd(); it != eit; ++it)
        {
            if (blockMemories.find((*it).second) == blockMemories.end())
            {
                log::debug << "Unterminated (dead?) block found" << log::end;
            }
        }
        
        // This is needed for example, if an endless loop occurs. In such a
        // case, there is no connection between the end block and the loop
        // body, which causes the loop to be removed.
        // To prevent that, all unreachable blocks are detected here and a
        // minimal set of root blocks is determined, that has to be kept alive,
        // in order to keep all other unreachable blocks alive as well.
        NodeSet unreachableBlocks;
        
        // Fill the set of blocks.
        map::addKeysToSet(blockMemories, unreachableBlocks);
        
        // Now remove all blocks that are reachable.
        // Note that we start from the end block and not from the end node, as
        // irg_block_walk_graph would do. The reason is, that this prevents
        // visiting kept-alive nodes, thay may already be present. We want to
        // keep the blocks AND nodes alive, not only the nodes, so removing the
        // blocks with kept-alive nodes now won't ensure this.
        ir_node* endBlock = get_irg_end_block(graph);
        irg_block_walk(endBlock, ft::removeFromSetWalker, 0, &unreachableBlocks);
        
        log::debug << "Found " << unreachableBlocks.size() <<
            " unreachable blocks" << log::end;
        
        if (!unreachableBlocks.empty())
        {
            ft::findRootBlocks(unreachableBlocks);
            log::debug << "Keeping " << unreachableBlocks.size() <<
                " unreachable root blocks alive" << log::end;
            
            // For each unreachable root block, keep the block and the last
            // memory value in it alive.
            BOOST_FOREACH (ir_node* blockNode, unreachableBlocks)
            {
                NodeMapIt blockMemoryIt = blockMemories.find(blockNode);
                assert(blockMemoryIt != blockMemories.end());
                
                keep_alive((*blockMemoryIt).second);
                keep_alive(blockNode);
            }
        }
    }
}
