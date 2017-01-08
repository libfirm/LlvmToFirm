#ifndef LTF_RAII_BLOCK_SCOPE_HPP_
#define LTF_RAII_BLOCK_SCOPE_HPP_

#include <boost/utility.hpp>
#include <libfirm/firm_types.h>

namespace ltf
{
    // Setup a new current block and restore it when leaving scope.
    class BlockScope : boost::noncopyable
    {
    private:
        ir_node* oldBlock;
        
    public:
        BlockScope(); // Just restores the current scope.
        BlockScope(ir_node* block);
        ~BlockScope();
        
        ir_node* getBlock() const;
    };
}

#endif /* LTF_RAII_BLOCK_SCOPE_HPP_ */
