#include "GraphBuilder.hpp"

#include <list>
#include <queue>
#include <boost/shared_ptr.hpp>
#include <boost/foreach.hpp>
#include <llvm/Support/Casting.h>
#include <llvm/Support/CFG.h>
#include <llvm/ADT/DepthFirstIterator.h>
#include <llvm/Function.h>
#include <llvm/BasicBlock.h>
#include <llvm/Instructions.h>
#include <libfirm/firm.h>
#include "../Builders/FrameBuilder.hpp"
#include "../Builders/BlockBuilder.hpp"
#include "../Builders/NodeBuilder.hpp"
#include "../Context.hpp"
#include "../Util/Logging.hpp"
#include "../Typedef/Vector.hpp"
using namespace boost;
using llvm::dyn_cast;
using llvm::idf_begin;
using llvm::idf_end;

namespace ltf
{
    /* ====================================================================== */
    /* =                         Build entry point                          = */
    /* ====================================================================== */
    
    ir_graph* GraphBuilder::doBuild(const llvm::Function* func, bool& doCache)
    {
        // Only build a graph for functions with a body.
        assert (!func->isDeclaration() &&
            "Can't build a graph for a function declaration");
        
        std::string mangledName = context.mangle(func);
        log::info << "Building function \"" << mangledName <<
            "\" (body)" << log::end;
        
        // Fetch the up-front built function entity.
        ir_entity* entity = context.retrieveEntity(func);
        assert((entity != 0) && "Missing function entity");

        // Create a new graph and a node builder for it.
        ir_graph* graph = new_ir_graph(entity, 0);
        set_irg_fp_model(graph, fpModel);

        // Not strictly neccessary, but it won't hurt anyway.
        log::debug << "Maturing start block" << log::end;
        mature_immBlock(get_irg_start_block(graph));
        
        /* ================================================================== */
        /* =                          Order blocks                          = */
        /* ================================================================== */
        
        // Instructions inside a block are guaranteed to be in correct order
        // (or the verifier will yield an error, reporting that an instruction
        // doesn't dominate all uses). This doesn't have to be true for blocks
        // though, as reordering blocks won't change execution order.
        //
        // Blocks can therefore be in a different order, than they are executed
        // in, but that would break instruction lookup. In order to solve that,
        // we need to order blocks, so that all data dependencies (except for
        // phi nodes) are satisfied.
        //
        // This is only of relevance, if there is exactly one predecessor block
        // (it would be handled by phi nodes otherwise and those always produce
        // a proxy value). Not that using a value from another block without a
        // phi node and multiple predecesors raises the above verifier error.
        //
        // So to sum it up, we have to ensure, that blocks with exactly one
        // predecessor actually occur after the predecessor. Such an ordering
        // can easily be accomplished, by visiting the successors, starting from
        // the entry block, using a depth-first search. This ensures, that
        // blocks are visited from predecessor to successor, except for cases
        // with multiple predecessors.

        log::debug << "Creating block order" << log::end;
        
        // That should be everything, thanks to LLVMs iterators. Note that this
        // will also ignore unreachable blocks, so we don't process them.
        BlockVect blocks;
        blocks.reserve(func->getBasicBlockList().size());
        blocks.insert(blocks.begin(), df_begin(func), df_end(func));
        
        /* ================================================================== */
        /* =                        Build frame type                        = */
        /* ================================================================== */

        const llvm::BasicBlock* entryBlock = &func->getEntryBlock();
        FrameBuilderSPtr frameBuilder = FrameBuilderSPtr(
            new FrameBuilder(context, graph)
        );
        
        // LLVM forbids the use of the entry block as a jump target. The entry
        // block is therefore guaranteed to be called exactly once and alloca
        // instructions in the entry block can therefore be used for the static
        // frame type.
        frameBuilder->disableOnDemandConstruction();
        
        BOOST_FOREACH (const llvm::Instruction& inst, entryBlock->getInstList())
        {
            if (const llvm::AllocaInst* allocaInst = dyn_cast<llvm::AllocaInst>(&inst))
            {
                frameBuilder->build(allocaInst);
            }
        }
        
        /* ================================================================== */
        /* =                          Build blocks                          = */
        /* ================================================================== */
        
        BlockBuilderSPtr blockBuilder = BlockBuilderSPtr(
            new BlockBuilder(context, graph)
        );
        
        // Register the entry block (it is already constructed, so it should not
        // be constructed like the other blocks below.
        blockBuilder->registerEntryBlock(entryBlock, get_cur_block());
        
        // Build the functions blocks up-front.
        BOOST_FOREACH (const llvm::BasicBlock& block, func->getBasicBlockList())
        {
            if (&block == entryBlock) continue;
            blockBuilder->build(&block);
        }
        
        blockBuilder->disableConstruction();

        /* ================================================================== */
        /* =                          Build nodes                           = */
        /* ================================================================== */
        
        NodeBuilder nodeBuilder(context, graph, blockBuilder, frameBuilder);

        // Build all nodes for the function.
        BOOST_FOREACH (const llvm::BasicBlock* block, blocks)
        {
            log::debug << "Building instructions in block \"" <<
                block->getNameStr() << "\"" << log::end;
            
            // Set the next block.
            ir_node* fBlock = blockBuilder->retrieve(block);
            assert(fBlock != 0);
            set_cur_block(fBlock);
            
            BOOST_FOREACH (const llvm::Instruction& inst, block->getInstList())
            {
                // Note, that nodes are guaranteed to be built (even phi nodes),
                // so there is no need for further iterations here. However phi
                // nodes are not complete yet, so they still need to be updated.
                nodeBuilder.build(&inst);
            }

            // Lower the reference count of the block (instructions done).
            // Note that phi nodes may have raised the reference count, so the
            // block may be matured later. Jumps may also be missing.
            blockBuilder->lowerReferenceCount(block);
        }

        log::debug << "Finalizing phi nodes" << log::end;
        
        // Replace the phi proxies by real phi nodes.
        BOOST_FOREACH (const llvm::BasicBlock* block, blocks)
        {
            // Set the current block.
            ir_node* fBlock = blockBuilder->retrieve(block);
            assert((fBlock != 0) && "Missing block");
            set_cur_block(fBlock);
            
            BOOST_FOREACH (const llvm::Instruction& inst, block->getInstList())
            {
                if (const llvm::PHINode* phi = dyn_cast<llvm::PHINode>(&inst))
                {
                    nodeBuilder.buildPhi(phi);
                }
            }
        }
        
        nodeBuilder.disableConstruction();
        
        /* ================================================================== */
        /* =                         Finalize graph                         = */
        /* ================================================================== */

        // Finish construction.
        blockBuilder->keepBlocksAlive();
        blockBuilder->matureRemainingBlocks();
        frameBuilder->finishConstruction();

        log::debug << "Maturing end block" << log::end;
        mature_immBlock(get_irg_end_block(graph));
        irg_finalize_cons(graph);

        // Optimize control flow.
        // TODO: ask if it is correct, that errors occur, if this line is omitted.
        //       (namely useless popl %edx when leaving a method, corrupting the
        //       newly restored stack pointer. try -O0 without this line.)
        optimize_cf(graph);
        
        // Verify the graph.
        irg_verify(graph, VRFY_ENFORCE_SSA);
        
        return graph;
    }
}
