#include "FirmTools.hpp"

#include <algorithm>
#include <boost/foreach.hpp>
#include <libfirm/firm.h>
using namespace boost;

namespace ltf
{
    namespace ft
    {
        void addToSetWalker(ir_node* node, void* nodeSetPtr)
        {
            typedef unordered_set<ir_node*> NodeSet;
            NodeSet* nodeSet = static_cast<NodeSet*>(nodeSetPtr);
            nodeSet->insert(node);
        }
        
        void removeFromSetWalker(ir_node* node, void* nodeSetPtr)
        {
            typedef unordered_set<ir_node*> NodeSet;
            NodeSet* nodeSet = static_cast<NodeSet*>(nodeSetPtr);
            nodeSet->erase(node);
        }
        
        /* ================================================================== */
        /* =                        Find root blocks                        = */
        /* ================================================================== */
        
        namespace
        {
            struct FindRootBlocksData
            {
                NodeSet* nodeSet;
                ir_node* startNode;
            };
            
            void findRootBlocksWalker(ir_node* blockNode, void* dataPtr)
            {
                // Get the data structure.
                FindRootBlocksData* data = static_cast<FindRootBlocksData*>(dataPtr);
                
                if (data->startNode != blockNode)
                {
                    // Remove the node. It can't be a root, because we reached
                    // it from somewhere else.
                    data->nodeSet->erase(blockNode);
                }
            }
        }
        
        void findRootBlocks(NodeSet& nodeSet)
        {
            FindRootBlocksData data;
            data.nodeSet = &nodeSet;
            
            BOOST_FOREACH (ir_node* blockNode, nodeSet)
            {
                // Walk the subtree of that block, removing all other blocks
                // found. Note that this doesn't invalidate the current iterator,
                // because nodeSet is an unordered_set.
                data.startNode = blockNode;
                irg_block_walk(blockNode, findRootBlocksWalker, 0, &data);
            }
            
            // Being here, there should only be the roots left, because the
            // blocks that are left cannot be reached from any other block in
            // the original set, except if that block was a child.
            // This can only happen for cycles and in such a case, the first
            // visited block in the cycle simply becomes it's root (because
            // after that node has been processed, all other nodes of the cycle
            // are gone).
        }
    }
}
