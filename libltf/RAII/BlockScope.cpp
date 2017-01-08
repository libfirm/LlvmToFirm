#include "BlockScope.hpp"

#include <cassert>
#include <libfirm/firm.h>
#include "../Util/Logging.hpp"

namespace ltf
{
    BlockScope::BlockScope()
        : oldBlock(get_cur_block()) { }
    
    BlockScope::BlockScope(ir_node* block)
        : oldBlock(get_cur_block())
    {
        assert(block != 0);
        
        if (block != oldBlock)
        {
            log::debug << "Switching to block " << get_irn_idx(block) << log::end;
            set_cur_block(block);
        }
    }
        
    BlockScope::~BlockScope()
    {
        if (oldBlock != get_cur_block())
        {
            log::debug << "Restoring block " << get_irn_idx(oldBlock) << log::end;
            set_cur_block(oldBlock);
        }
    }
    
    ir_node* BlockScope::getBlock() const
    {
        return oldBlock;
    }
}
