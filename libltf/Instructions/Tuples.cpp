#include "../Builders/NodeBuilder.hpp"

#include <iterator>
#include <algorithm>
#include <boost/foreach.hpp>
#include <llvm/Constant.h>
#include <llvm/Constants.h>
#include <llvm/Instructions.h>
#include <llvm/DerivedTypes.h>
#include <llvm/Support/Casting.h>
#include <libfirm/firm.h>
#include "../Context.hpp"
#include "../Util/TypeInfo.hpp"
#include "../Util/Casting.hpp"
#include "../Util/Logging.hpp"
#include "../Util/FirmTools.hpp"
#include "../Util/LlvmTools.hpp"
#include "../Exceptions/NotSupportedException.hpp"
using llvm::isa;
using llvm::cast;

// Firm doesn't support structs or arrays as modes. It does however provide
// tuples, that can be used to emulate them. A LLVM value on the other hand can
// be one of those types (and not just a pointer to that type) and in fact they
// are also used as initializer, which again needs special treatment in firm
// (see EntityBuilder.cpp).
// The usual firm way would be, to keep the data structure in the frame type
// and access it using load/store. This however is problematic, because all
// operations on the aggregate will produce a "copy" in LLVM (the old value may
// or may not be used anymore) and because alloca is scoped and hard to handle
// for loops.
// Since the aggregates seem to be used for small values only, using firm tuples
// to emulate their behaviour seems appropriate. However since aggregates can be
// passed to other functions and loaded/stored whereas tuple can not, those
// operations need to serialize or deserialize the aggregate into a struct in
// memory, that can be passed around in firm (which may then copy the value or
// the pointer, depending on the actual type).

namespace ltf
{
    // Array and structure constants.
    ir_node* NodeBuilder::buildTupleConstant(const llvm::Constant* constant)
    {
        // Build an array of all tuple values.
        unsigned int arity = ti::getTupleSize(constant->getType());
        ir_node*     nodes[arity];
        
        for (unsigned int i = 0; i < arity; i++)
        {
            nodes[i] = retrieve(ti::getTupleEntry(constant, i));
        }
        
        // Then tupelize them.
        return new_Tuple(arity, nodes);
    }
    
    ir_node* NodeBuilder::buildTupleUndef(const llvm::UndefValue* constant)
    {
        // Build an array of all operand values.
        unsigned int arity = ti::getTupleSize(constant->getType());
        ir_node*     nodes[arity];
        
        for (unsigned int i = 0; i < arity; i++)
        {
            // Fill the array with undefs of the appropriate type. Note that
            // this might recurse back here, for tuples in tuples.
            nodes[i] = retrieve(llvm::UndefValue::get(
                ti::getTupleType(constant->getType(), i)
            ));
        }
        
        // Then tupelize them.
        return new_Tuple(arity, nodes);
    }
    
    // Extract the value at the given indices from the (nested) tuples.
    ir_node* NodeBuilder::buildTupleExtract(ir_node* tuple,
        const llvm::Type* type, const UIntVect& indices)
    {
        assert(!indices.empty());
        ir_mode* mode;
        
        BOOST_FOREACH (unsigned int index, indices)
        {
            assert(ti::isTuple(type));
            assert(index < ti::getTupleSize(type));
            
            // Get the next value and its type.
            type  = ti::getTupleType(type, index);
            mode  = ti::getBaseMode(type);
            tuple = new_Proj(tuple, mode, index);
        }
        
        return tuple;
    }
    
    // Creates a new (nested) tuple with the value at the given indices
    // replaced by the given value.
    ir_node* NodeBuilder::buildTupleInsert(ir_node* tuple,
        const llvm::Type* type, const UIntVect& indices, ir_node* value)
    {
        if (indices.empty()) return tuple;
        assert(ti::isTuple(type));
        
        unsigned int index = indices[0];
        unsigned int arity = ti::getTupleSize(type);
        ir_node*     nodes[arity];
        
        UIntVect extractIndices;
        extractIndices.resize(1);
        
        // Copy all but the tuple at the index.
        for (unsigned int i = 0; i < arity; i++)
        {
            if (i == index) continue;
            
            extractIndices[0] = i;
            nodes[i] = buildTupleExtract(tuple, type, extractIndices);
        }
        
        // Either substitute the node, or create a tuple by recursion.
        if (indices.size() == 1)
        {
            nodes[index] = value;
        }
        else
        {
            // Insert on the nested tuple.
            extractIndices[0] = index;
            const llvm::Type* nestedType = ti::getTupleType(type, index);
            ir_node*          nestedNode = buildTupleExtract(
                tuple, type, extractIndices
            );

            // Use a reduced index list.
            UIntVect::const_iterator it = indices.begin();
            ++it;
            
            UIntVect nextIndices;
            nextIndices.reserve(indices.size() - 1);
            std::copy(it, indices.end(), std::back_inserter(nextIndices));
            
            nodes[index] = buildTupleInsert(
                nestedNode, nestedType, nextIndices, value
            );
        }
        
        return new_Tuple(arity, nodes);
    }

    // Emits code, that stores a tuple at a given memory location. The caller
    // has to allocate space with a type that corresponds to the tuple.
    void NodeBuilder::buildTupleStore(ir_node* tuple, ir_node* pointer,
        const llvm::Type* type)
    {
        assert(ti::isTuple(type));
        assert((!ti::isBigInt(type) || !ti::isModInt(type)) &&
            "Can't store bigint modulo types");
        
        std::vector<llvm::Value*> indices;
        indices.resize(1);
        
        unsigned int arity = ti::getTupleSize(type);
        for (unsigned int i = 0; i < arity; i++)
        {
            const llvm::Type* itemType = ti::getTupleType(type, i);
            ir_mode*          itemMode = ti::getBaseMode(itemType);
            ir_node*          itemNode = new_Proj(tuple, itemMode, i);
            
            // Obtain a pointer to the element to store.
            indices[0] = llvm::ConstantInt::get(
                llvm::IntegerType::getInt32Ty(llvm::getGlobalContext()), i
            );
            
            // We can't directly access the words of a big int using getptr.
            // But we can use the replacement struct type, because in firm it
            // is exactly that kind of thing.
            if (ti::isBigInt(type))
            {
                type = ti::getBigIntStruct(type);
            }
            
            ir_node* ptrNode = buildGetPtr(pointer, type, indices);
            
            // Recurse on aggregate types.
            if (ti::isTuple(itemType))
            {
                buildTupleStore(
                    itemNode, ptrNode,
                    cast<llvm::CompositeType>(itemType)
                );
            }
            // Storing unknown is pretty pointless. Ignore them.
            else if (get_irn_op(itemNode) != op_Unknown)
            {
                // Store the value from the tuple.                
                ir_node* storeNode = new_Store(
                    get_store(), ptrNode, itemNode, cons_none
                );
                
                set_store(new_Proj(storeNode, mode_M, pn_Store_M));
            }
        }
    }
    
    // Emits code, that loads a data structure from a given memory location
    // and turns it into a tuple. Note that loading of fields, which are never
    // accessed should be removed by dead code elimination.
    ir_node* NodeBuilder::buildTupleLoad(ir_node* pointer, const llvm::Type* type)
    {
        assert(ti::isTuple(type));
        assert((!ti::isBigInt(type) || !ti::isModInt(type)) &&
            "Can't load bigint modulo types");
        
        std::vector<llvm::Value*> indices;
        indices.resize(1);
        
        unsigned int arity = ti::getTupleSize(type);
        ir_node*     nodes[arity];
        
        for (unsigned int i = 0; i < arity; i++)
        {
            const llvm::Type* itemType = ti::getTupleType(type, i);
            ir_mode*          itemMode = ti::getBaseMode(itemType);
            
            // Obtain a pointer to the element to load.
            indices[0] = llvm::ConstantInt::get(
                llvm::IntegerType::getInt32Ty(llvm::getGlobalContext()), i
            );
            
            // See buildTupleStore().
            if (ti::isBigInt(type))
            {
                type = ti::getBigIntStruct(type);
            }
            
            ir_node* ptrNode = buildGetPtr(pointer, type, indices);
            
            // Recurse on aggregate types.
            if (ti::isTuple(itemType))
            {
                nodes[i] = buildTupleLoad(
                    ptrNode,
                    cast<llvm::CompositeType>(itemType)
                );
            }
            else
            {
                // Load the value for the tuple.
                ir_node* loadNode = new_Load(
                    get_store(), ptrNode, itemMode, cons_none
                );
                
                set_store(new_Proj(loadNode, mode_M, pn_Load_M));
                nodes[i] = new_Proj(loadNode, itemMode, pn_Load_res);
            }
        }
        
        return new_Tuple(arity, nodes);
    }
    
    // [aggregate] -> [atom] | [aggregate]
    ir_node* NodeBuilder::buildExtractValue(const llvm::ExtractValueInst* inst)
    {
        log::debug << "Building aggregate extract" << log::end;
        
        if (!ti::isAggregate(inst->getAggregateOperand()->getType()))
        {
            throw NotSupportedException("Non-aggregate extractvalue");
        }
        
        // Normalize the operand node.
        const llvm::Value* operandValue = inst->getAggregateOperand();
        ir_node*           operandNode  = retrieve(operandValue);
        
        UIntVect indices;
        indices.reserve(inst->getNumIndices());
        std::copy(inst->idx_begin(),
                  inst->idx_end(), std::back_inserter(indices));

        // Use the given indices, to select the value on the retrieved tuple.
        return buildTupleExtract(operandNode, operandValue->getType(), indices);
    }
    
    // ([aggregate], [atom] | [aggregate]) -> [aggregate]
    ir_node* NodeBuilder::buildInsertValue(const llvm::InsertValueInst* inst)
    {
        log::debug << "Building aggregate insert" << log::end;
        
        if (!ti::isAggregate(inst->getAggregateOperand()->getType()) || (
            !ti::isAtom(inst->getInsertedValueOperand()->getType()) &&
            !ti::isAggregate(inst->getInsertedValueOperand()->getType())))
        {
            throw NotSupportedException("Non-aggregate / invalid insertvalue");
        }

        // Normalize the operand node.
        const llvm::Value* operandValue = inst->getAggregateOperand();
        ir_node*           operandNode  = retrieve(operandValue);

        // Normalize the value node.
        const llvm::Value* value     = inst->getInsertedValueOperand();
        ir_node*           valueNode = retrieve(value);
        
        if (ti::isAtom(value->getType()))
        {
            valueNode = ac::atomToBase(value->getType(), valueNode, false);
        }
        
        UIntVect indices;
        indices.reserve(inst->getNumIndices());
        std::copy(inst->idx_begin(),
                  inst->idx_end(), std::back_inserter(indices));
        
        // Use the given indices, to insert the value on the retrieved tuple.
        return buildTupleInsert(
            operandNode, operandValue->getType(), indices, valueNode
        );
    }
}
