#ifndef LTF_FRAME_BUILDER_HPP_
#define LTF_FRAME_BUILDER_HPP_

//           LLVM             FIRM
// Converts: AllocaInst ----> ir_entity
//
// Never returns null.

#include <string>
#include <boost/shared_ptr.hpp>
#include <libfirm/firm_types.h>
#include "Builder.hpp"

namespace llvm
{
    class Type;
    class AllocaInst;
}

// Turns alloca instructions into entities on the frame type of the given graph.
namespace ltf
{
    class Context;
    
    class FrameBuilder : public Builder<const llvm::AllocaInst*, ir_entity*>
    {
    public:
        FrameBuilder(Context& context, ir_graph* graph);

        ir_entity* retrieveReturnEntity    (const llvm::Type* type);
        ir_entity* retrieveAnonymousEntity (const llvm::Type* type);
        
        void finishConstruction();
        
    protected:
        ir_entity* doBuild(const llvm::AllocaInst* inst, bool& doCache);
        
    private:
        ir_entity* buildEntity(
            const llvm::Type* type, const std::string& prefix = "field"
        );
        
        Context& context;
        typedef Builder<const llvm::AllocaInst*, ir_entity*> Base;
        
        ir_type* fFrameType;
        int offset;
        int index;
        int maxAlignment;
        
        ir_entity* returnEntity;
    };
}

#endif /* LTF_FRAME_BUILDER_HPP_ */
