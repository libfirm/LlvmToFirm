#ifndef LTF_BLD_TYPE_METAKEY_HPP_
#define LTF_BLD_TYPE_METAKEY_HPP_

#include "../Typedef/Vector.hpp"

namespace llvm
{
    class Type;
    class AttrListPtr;
}

namespace ltf
{
    /* ================================================================== */
    /* =                         Metakey types                          = */
    /* ================================================================== */
    
    struct TypeMetakeyType
    {
        enum Enum
        {
            Function
        };
    };
    
    typedef TypeMetakeyType::Enum TypeMetakeyTypeE;
    
    /* ================================================================== */
    /* =                       Metakey base type                        = */
    /* ================================================================== */
    
    class TypeMetakey
    {
    public:
        TypeMetakey() : hashValue(0) { }
        std::size_t getHashValue() const { return hashValue; }
        
        virtual bool operator==(const TypeMetakey& other) const = 0;
        virtual TypeMetakeyTypeE getType() const = 0;
        
    protected:
        void setHashValue(std::size_t hashValue)
        {
            this->hashValue = hashValue;
        }
        
    private:
        std::size_t hashValue;
    };
    
    /* ================================================================== */
    /* =                     Function type metakey                      = */
    /* ================================================================== */
    
    // Function types need additional metadata, before they can be be resolved
    // to firm types. These are the indices of parameters passed by value, as
    // well as the additional variadic parameters for call types.
    
    class FunctionTypeMetakey : public TypeMetakey
    {
    private:
        // Parameters passed by value and additional parameters.
        UIntVect byValIndices;
        TypeVect variadicParams;
        unsigned callingConvention;
        
        std::size_t calcHashValue();
        
    public:
        FunctionTypeMetakey();
        
        bool operator==(const TypeMetakey& other) const;
        
        TypeMetakeyTypeE getType() const
        {
            return TypeMetakeyType::Function;
        }
        
        void addByValIndex    (unsigned index);
        void addVariadicParam (const llvm::Type* paramType);
        
        // Get/set LLVM calling convention.
        void setCallingConvention(unsigned callingConvention)
        {
            this->callingConvention = callingConvention; 
        }
        
        unsigned getCallingConvention()
        {
            return callingConvention;
        }
        
        unsigned getByValIndex(unsigned index)
        {
            return byValIndices[index];
        }
        
        const llvm::Type* getVariadicParam(unsigned index)
        {
            return variadicParams[index];
        }
        
        unsigned getNumByValIndices()   { return byValIndices.size(); }
        unsigned getNumVariadicParams() { return variadicParams.size(); }
        
        bool isByValIndex(unsigned index);
        void addAttributes(const llvm::AttrListPtr& attributes);
    };
}

#endif /* LTF_BLD_TYPE_METAKEY_HPP_ */
