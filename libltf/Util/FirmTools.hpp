#ifndef LTF_UTIL_FIRM_TOOLS_HPP_
#define LTF_UTIL_FIRM_TOOLS_HPP_

#include <libfirm/firm_types.h>
#include "../Typedef/Set.hpp"

namespace ltf
{
    namespace ft
    {
        // Intended to be passed to one of the functions in irgwalk.h   
        /* ================================================================== */
        /* =                        Walker functions                        = */
        /* ================================================================== */
        
        // Removes/adds the visited nodes from the given boost::unordered_set.
        void addToSetWalker      (ir_node* node, void* nodeSetPtr);
        void removeFromSetWalker (ir_node* node, void* nodeSetPtr);

        // Given a set of block nodes, find the smallest subset of blocks, so
        // that all other blocks can be reached from that set.
        void findRootBlocks(NodeSet& nodeSet);
    }
}

#endif /* LTF_UTIL_FIRM_TOOLS_HPP_ */
