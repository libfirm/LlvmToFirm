#include "FrameBuilder.hpp"

#include <cassert>
#include <sstream>
#include <llvm/Instructions.h>
#include <llvm/Support/Casting.h>
#include <llvm/Target/TargetData.h>
#include <libfirm/firm.h>
#include "../Util/Logging.hpp"
#include "../Util/StringTools.hpp"
#include "../Context.hpp"
#include "../Exceptions/NotImplementedException.hpp"
using llvm::isa;
using llvm::cast;

namespace ltf
{
    FrameBuilder::FrameBuilder(Context& context, ir_graph* graph)
        : context(context), offset(0), index(0), maxAlignment(1),
          returnEntity(0)
    {
        assert(graph != 0);
        fFrameType = get_irg_frame_type(graph);
    }
    
    ir_entity* FrameBuilder::retrieveReturnEntity(const llvm::Type* type)
    {
        if (returnEntity == 0)
        {
            returnEntity = buildEntity(type, "retval");
        }

        return returnEntity;
    }
    
    ir_entity* FrameBuilder::retrieveAnonymousEntity(const llvm::Type* type)
    {
        return buildEntity(type, "anonymous");
    }
    
    /* ====================================================================== */
    /* =                         Build entry point                          = */
    /* ====================================================================== */
    
    ir_entity* FrameBuilder::doBuild(const llvm::AllocaInst* inst, bool& doCache)
    {
        // Get the allocation type and convert it.
        const llvm::Type* type   = inst->getAllocatedType();
        ir_entity*        entity = 0;
        
        if (inst->isArrayAllocation())
        {
            // The array size has to be constant, to construct an entity.
            if (!isa<llvm::ConstantInt>(inst->getArraySize()))
            {
                // We can't replace this by a static frame entity, the size is
                // dynamic (or at least a more complex constant expression).
                log::debug << "Array allocation with non-const size" << log::end;
                return 0;
            }
            
            // Get the array size. This should be i32.
            const llvm::ConstantInt* sizeValue = cast<llvm::ConstantInt>(
                inst->getArraySize()
            );
            
            // Turn the type into an array type.
            type = llvm::ArrayType::get(type, sizeValue->getLimitedValue());
        }
        
        // Create an entity on the frame.
        if (inst->hasName())
        {
            std::string name = inst->getNameStr();
            str::remove(name, ' ');
            entity = buildEntity(type, name);
        }
        else
        {
            entity = buildEntity(type);
        }
        
        return entity;
    }
    
    ir_entity* FrameBuilder::buildEntity(const llvm::Type* type,
        const std::string& prefix)
    {
        ir_type* fType = context.retrieveType(type);
        
        // Create a field identifier.
        std::ostringstream nameStr;
        nameStr << prefix << "_#" << index;
        index++;
        
        log::debug << "Building frame entity \"" <<
            nameStr.str() << "\"" << log::end;
        
        // Create an entity for the field and put it in the frame.
        ident*     entityId = new_id_from_str(nameStr.str().c_str());
        ir_entity* entity   = new_entity(fFrameType, entityId, fType);
        
        int alignment = context.getTargetData()->getPrefTypeAlignment(type);
        set_entity_alignment(entity, alignment);
        
        // Advance to the next aligned offset.
        int displacement = offset % alignment;
        if (displacement > 0)
        {
            offset += alignment - displacement;
        }
        
        if (alignment > maxAlignment)
        {
            maxAlignment = alignment;
        }
        
        // Apply alignment, advance the offset.
        set_entity_offset(entity, offset);
        offset += get_type_size_bytes(fType);
        
        return entity;
    }

    /* ====================================================================== */
    /* =                        Finish construction                         = */
    /* ====================================================================== */
    
    void FrameBuilder::finishConstruction()
    {
        log::debug << "Finishing frame type" << log::end;
        
        // Set the size of the final frame and make sure the alignment is set.
        // Do not fix the layout though, the optimization stage will want to
        // change frame type layouts.
        set_type_size_bytes(fFrameType, offset);
        set_type_alignment_bytes(fFrameType, maxAlignment);
        
        disableConstruction();
    }
}
