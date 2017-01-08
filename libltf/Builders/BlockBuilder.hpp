#ifndef LTF_BLD_BLOCK_BUILDER_HPP_
#define LTF_BLD_BLOCK_BUILDER_HPP_

#include <utility>
#include <iterator>
#include <algorithm>
#include <boost/foreach.hpp>
#include <libfirm/firm_types.h>
#include "Builder.hpp"
#include "../Typedef/Map.hpp"
#include "../Typedef/Set.hpp"

namespace llvm
{
    class BasicBlock;
}

namespace ltf
{
    class Context;
    
    class BlockBuilder : public Builder<const llvm::BasicBlock*, ir_node*>
    {
    public:
        BlockBuilder(Context& context, ir_graph* graph);
        
        // If all entry points are resolved and all instructions are processed,
        // the block will be matured here.
        void lowerReferenceCount (const llvm::BasicBlock* block, int amount = 1);
        void raiseReferenceCount (const llvm::BasicBlock* block, int amount = 1);
        void registerEntryBlock  (const llvm::BasicBlock* block, ir_node* fBlock);
        ir_node* getEntryBlock();

        // Register a jump between blocks. This will set up the block relation
        // in firm and update the blocks reference count.
        void registerJump(
            const llvm::BasicBlock* srcBlock,
            const llvm::BasicBlock* dstBlock = 0,
            ir_node* predNode = 0
        );

        // Can be used, to redirect phi dependencies from the source to the
        // target block. The blocks in an if-cascade for example will redirect
        // phi dependencies to the block with the original switch statement, so
        // that whenever a phi instruction uses that block as phi dependency, it
        // can resolve it using a block from the switch.
        void redirectPhi(ir_node* srcBlock, ir_node* dstBlock);
        
        void matureRemainingBlocks();
        void keepBlocksAlive();
        
    protected:
        ir_node* doBuild(const llvm::BasicBlock* block, bool& doCacheValue);
        void clearCache();
        
    private:
        typedef Builder<const llvm::BasicBlock*, ir_node*> Base;
        
        Context& context;
        ir_graph* graph;
        ir_node* fEntryBlock;
        
        // XXX: store this together, maybe add support for extended data types
        // to the builder object?
        
        // Reference counting for immature blocks.
        typedef boost::unordered_map<const llvm::BasicBlock*, int> BlockToIntMap;
        typedef boost::unordered_map<ir_node*, NodeSet>            NodeToNodeSetMap;
        
        typedef std::pair<const llvm::BasicBlock*, int> BlockIntPair;
        typedef BlockToIntMap::iterator                 BlockToIntMapIt;
        typedef NodeToNodeSetMap::iterator              NodeToNodeSetMapIt;
        
        BlockToIntMap    refCounts;
        NodeToNodeSetMap phiRedirects;
        NodeMap          blockMemories;
        
        void initReferenceCount (const llvm::BasicBlock* block);
        void matureBlock        (const llvm::BasicBlock* block);
        
    public:
        template<typename OutputIterator>
        void fetchPhiSources(ir_node* block, OutputIterator oit)
        {
            // The block itself is always a possible source.
            *oit = block;
            ++oit;
            
            NodeToNodeSetMapIt it = phiRedirects.find(block);
            if (it != phiRedirects.end())
            {
                // Copy all redirects to the output.
                std::copy(it->second.begin(), it->second.end(), oit);
            }
        }
    };
}

#endif /* LTF_BLD_BLOCK_BUILDER_HPP_ */
