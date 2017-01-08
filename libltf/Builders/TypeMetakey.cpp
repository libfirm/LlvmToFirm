#include "TypeMetakey.hpp"

#include <numeric>
#include <algorithm>
#include <boost/functional/hash.hpp>
#include <llvm/Attributes.h>
#include <llvm/CallingConv.h>
using namespace boost;

namespace ltf
{
    namespace
    {
        // Functor to accumulate hash values.
        template<typename ItemT>
        struct HashCombine
        {
            std::size_t operator()(std::size_t hash, ItemT item) const
            {
                hash_combine(hash, item);
                return hash;
            }
        };
        
        typedef HashCombine<int>               IntCombine;
        typedef HashCombine<const llvm::Type*> TypeCombine;
    }

    // Use cdecl as default calling convention.
    FunctionTypeMetakey::FunctionTypeMetakey()
        : callingConvention(llvm::CallingConv::C)
    { }
    
    /* ====================================================================== */
    /* =                     Hashing and equality test                      = */
    /* ====================================================================== */
    
    std::size_t FunctionTypeMetakey::calcHashValue()
    {
        std::size_t hash = 0;
        
        // Combine all values in the object.
        hash = std::accumulate(
            byValIndices.begin(), byValIndices.end(), hash, IntCombine()
        );
        
        hash = std::accumulate(
            variadicParams.begin(), variadicParams.end(), hash, TypeCombine()
        );
        
        hash_combine(hash, callingConvention);
        
        return hash;
    }
    
    bool FunctionTypeMetakey::operator==(const TypeMetakey& otherBase) const
    {
        if (getType() != otherBase.getType()) return false;
        const FunctionTypeMetakey& other = reinterpret_cast<
            const FunctionTypeMetakey&>(otherBase);
        
        // Compare the value indices.
        if ((byValIndices.size() != other.byValIndices.size()) ||
            !std::equal(byValIndices.begin(),
                        byValIndices.end(),
                        other.byValIndices.begin()))
        {
            return false;
        }
        
        // Compare the variadic parameters.
        if (variadicParams.size() != other.variadicParams.size() ||
            !std::equal(variadicParams.begin(),
                        variadicParams.end(),
                        other.variadicParams.begin()))
        {
            return false;
        }
        
        if (callingConvention != other.callingConvention)
        {
            return false;
        }
        
        return true;
    }
    
    /* ====================================================================== */
    /* =                          Access metadata                           = */
    /* ====================================================================== */
    
    void FunctionTypeMetakey::addByValIndex(unsigned int index)
    {
        // Find the proper insertion point.
        UIntVectIt indexIt = std::lower_bound(
            byValIndices.begin(), byValIndices.end(), index
        );
        
        // Insert the index, if it is not already present.
        if ((indexIt == byValIndices.end()) || (*indexIt != index))
        {
            byValIndices.insert(indexIt, index);
        }
        
        setHashValue(calcHashValue());
    }
    
    void FunctionTypeMetakey::addVariadicParam(const llvm::Type* paramType)
    {
        // Add the param to the metadata.
        variadicParams.push_back(paramType);
        setHashValue(calcHashValue());
    }
    
    void FunctionTypeMetakey::addAttributes(const llvm::AttrListPtr& attributes)
    {
        // Scan all attributes.
        for (unsigned int i = 0; i < attributes.getNumSlots(); i++)
        {
            const llvm::AttributeWithIndex& attribute = attributes.getSlot(i);
            if ((attribute.Index == 0) || (attribute.Index == ~0U)) continue;
            
            if ((attribute.Attrs & llvm::Attribute::ByVal) != 0)
            {
                // Return type is index 0.
                unsigned int index = attribute.Index - 1;
                addByValIndex(index);
            }
        }
    }
    
    bool FunctionTypeMetakey::isByValIndex(unsigned int index)
    {
        return std::binary_search(byValIndices.begin(), byValIndices.end(), index);
    }
}
