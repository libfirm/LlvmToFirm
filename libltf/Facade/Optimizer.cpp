#include "Optimizer.hpp"
#include <libfirm/firm.h>

namespace ltf
{
    void Optimizer::repairFrameTypes()
    {
        // Redo frame type layout. Some optimizations need to change the frame
        // type (inlining for example). Note that type sizes are properly set
        // by the construction phase and that usual structs are fixed during
        // construction, so we can trust those sizes.
        // This is the same for all optimizers, so it is provided here.
        for (int i = 0; i < get_irp_n_irgs(); i++)
        {
            ir_graph* graph      = get_irp_irg(i);
            ir_type*  fFrameType = get_irg_frame_type(graph);

            int offset       = 0;
            int maxAlignment = 1;
            
            for (int j = 0; j < get_class_n_members(fFrameType); j++)
            {
                // Alignment should already be set.
                ir_entity* entity    = get_class_member(fFrameType, j);
                ir_type*   fType     = get_entity_type(entity);
                int        alignment = get_entity_alignment(entity);
                assert((alignment > 0) && "Entity has no alignment");
                
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
            }
            
            // Set final type and alignment.
            set_type_size_bytes(fFrameType, offset);
            set_type_alignment_bytes(fFrameType, maxAlignment);
        }
    }
    
    void Optimizer::finalizeFrameTypes()
    {
        for (int i = 0; i < get_irp_n_irgs(); i++)
        {
            ir_graph* graph      = get_irp_irg(i);
            ir_type*  fFrameType = get_irg_frame_type(graph);
            set_type_state(fFrameType, layout_fixed);
        }
    }
}
