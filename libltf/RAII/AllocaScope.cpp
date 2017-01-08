#include "AllocaScope.hpp"

#include <boost/foreach.hpp>
#include <libfirm/firm.h>
#include "../Util/Logging.hpp"

namespace ltf
{
    AllocaScope::~AllocaScope()
    {
        release();
    }
    
    ir_node* AllocaScope::allocate(ir_type* type)
    {
        log::debug << "Constructing allocation on the stack" << log::end;
        
        // Allocate memory.
        ir_node* oneConstNode = new_Const_long(mode_Iu, 1);
        ir_node* allocNode = new_Alloc(
            get_store(), oneConstNode, type, stack_alloc
        );
        
        // Update the store, retrieve a pointer.
        ir_node* storeProjNode = new_Proj(allocNode, mode_M, pn_Alloc_M);
        ir_node* pointerNode   = new_Proj(allocNode, mode_P, pn_Alloc_res);
        set_store(storeProjNode);
        
        // Store the pointer and type.
        memoryChunks.push_back(MemoryChunk(pointerNode, type));
        return pointerNode;
    }

    void AllocaScope::release()
    {
        BOOST_FOREACH (MemoryChunk chunk, memoryChunks)
        {
            log::debug << "Constructing free on the stack" << log::end;
            
            // Free the object again.
            ir_node* oneConstNode = new_Const_long(mode_Iu, 1);
            ir_node* freeNode = new_Free(
                get_store(), chunk.first, oneConstNode, chunk.second, stack_alloc
            );
            
            set_store(freeNode);
        }
        
        memoryChunks.clear();
    }
}
