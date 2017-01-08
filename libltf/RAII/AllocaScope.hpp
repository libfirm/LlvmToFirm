#ifndef LTF_RAII_ALLOCA_SCOPE_HPP_
#define LTF_RAII_ALLOCA_SCOPE_HPP_

#include <vector>
#include <utility>
#include <boost/utility.hpp>
#include <libfirm/firm_types.h>

namespace ltf
{
    class AllocaScope : boost::noncopyable
    {
    public:
        ~AllocaScope();
        
        ir_node* allocate(ir_type* type);
        void release();
        
    private:
        typedef std::pair<ir_node*, ir_type*> MemoryChunk;
        std::vector<MemoryChunk> memoryChunks;
    };
}

#endif /* LTF_RAII_ALLOCA_SCOPE_HPP_ */
