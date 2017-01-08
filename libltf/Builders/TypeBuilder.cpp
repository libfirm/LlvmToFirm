#include "TypeBuilder.hpp"

#include <climits>
#include <sstream>
#include <llvm/Type.h>
#include <llvm/Module.h>
#include <llvm/CallingConv.h>
#include <llvm/DerivedTypes.h>
#include <llvm/Support/Casting.h>
#include <llvm/Target/TargetData.h>
#include <libfirm/firm.h>
#include "../Util/Logging.hpp"
#include "../Util/StringTools.hpp"
#include "../Context.hpp"
#include "../Exceptions/NotImplementedException.hpp"
#include "../Exceptions/NotSupportedException.hpp"
#include "../Util/TypeInfo.hpp"
using namespace boost;
using llvm::isa;
using llvm::cast;
using llvm::dyn_cast;

namespace ltf
{
    TypeBuilder::TypeBuilder(Context& context)
        : context(context), uniqueCounter(0) { }
    
    /* ====================================================================== */
    /* =                          Build functions                           = */
    /* ====================================================================== */
    
    ir_type* TypeBuilder::lookupFunction(const llvm::FunctionType* type,
        boost::shared_ptr<FunctionTypeMetakey> metadata)
    {
        return lookup(type, metadata);
    }
    
    ir_type* TypeBuilder::retrieveFunction(const llvm::FunctionType* type,
        boost::shared_ptr<FunctionTypeMetakey> metadata)
    {
        ir_type* fType = lookupFunction(type, metadata);
        
        if (fType == 0)
        {
            bool doCacheValue = true;
            fType = buildFunction(type, metadata, doCacheValue);
            
            if (doCacheValue)
            {
                cacheInsert(type, metadata, fType);
            }
        }
        
        return fType;
    }

    /* ====================================================================== */
    /* =                         Build entry point                          = */
    /* ====================================================================== */
    
    ir_type* TypeBuilder::doBuild(const llvm::Type* type, bool& doCache)
    {
        // Find the appropriate build method.
        switch (type->getTypeID())
        {
        case llvm::Type::StructTyID:
            return buildStruct(cast<llvm::StructType>(type), doCache);
                    
        case llvm::Type::FunctionTyID:
            assert(!"Function lookup needs additional metadata");
        
        case llvm::Type::IntegerTyID:
            return buildInteger(cast<llvm::IntegerType>(type));
            
        case llvm::Type::PointerTyID:
            return buildPointer(cast<llvm::PointerType>(type), doCache);
            
        case llvm::Type::ArrayTyID:
            return buildArray(cast<llvm::ArrayType>(type));
            
        case llvm::Type::FloatTyID:
        case llvm::Type::DoubleTyID:
        case llvm::Type::X86_FP80TyID:
            return buildFloat(type);
            
        case llvm::Type::OpaqueTyID:
            return buildOpaque(cast<llvm::OpaqueType>(type));
        }
        
        std::ostringstream errorStream;
        errorStream << "Unsupported type \"";
        type->print(errorStream);
        errorStream << "\"";
        
        throw NotImplementedException(errorStream.str());
    }
    
    /* ====================================================================== */
    /* =                          Primitive types                           = */
    /* ====================================================================== */
    
    ir_type* TypeBuilder::buildFloat(const llvm::Type* type)
    {
        log::debug << "Converting float type \"";
        type->print(log::debug);
        log::debug << "\"" << log::end;
        
        ir_mode* mode = ti::getBaseMode(type);
        assert(mode != 0);
        assert(mode_is_float(mode) && "Floating type with non-float mode");
        ir_type* fType = new_type_primitive(mode);
        
        // Derive alignment information from LLVMs target data.
        set_type_alignment_bytes(fType, context.getTargetData()->
            getPrefTypeAlignment(type));

        return fType;
    }
    
    ir_type* TypeBuilder::buildInteger(const llvm::IntegerType* type)
    {
        log::debug << "Building integer type \"";
        type->print(log::debug);
        log::debug << "\"" << log::end;

        ir_type* fType = 0;
        
        if (ti::isBigInt(type))
        {
            log::debug << "Big int type construction" << log::end;
            
            // Create a replacement struct.
            std::ostringstream nameStr;
            type->print(nameStr);
            
            bool doCache = false;
            return buildStruct(ti::getBigIntStruct(type), doCache, nameStr.str());
        }
        else
        {
            // Construct the firm type. 
            ir_mode* mode = ti::getBaseMode(type);
            assert(mode != 0);
            assert(mode_is_int(mode) && "Integer type with non-integer mode");
            fType = new_type_primitive(mode);
            
            // Derive alignment information from LLVMs target data.
            set_type_alignment_bytes(fType, context.getTargetData()->
                getPrefTypeAlignment(type));
        }

        assert(fType != 0);
        return fType;
    }
    
    ir_type* TypeBuilder::buildOpaque(const llvm::OpaqueType* type)
    {
        ident* typeId = createIdentifier("opaque", uniqueCounter);
        uniqueCounter++;
        
        // Just returning an empty struct should do the trick.
        return new_type_struct(typeId);
    }
    
    /* ====================================================================== */
    /* =                              Pointers                              = */
    /* ====================================================================== */

    // [TODO] address space attrbute?
    ir_type* TypeBuilder::buildPointer(const llvm::PointerType* type, bool& doCache)
    {
        // Recursive data types will usually always involve a pointer type
        // (arrays are no pointers, so they are safe), since the types size is
        // not known before it is constructed and it can thus not be embedded.
        // Even more so, if it could be embedded, that would produce an
        // infinitely big data type.
        //
        // Also for C/C++ and probably most similar languages, recursive data
        // structures will almost always involve structs, as they can be
        // forward-declarated, allowing their use in a pointer before they
        // are constructed. The situation in firm is similar. Structures can
        // be partially constructed and thus be recursive. Functions could be
        // as well (although i'm not aware of any way to do that in C without
        // a struct).
        //
        // So there are two things that should be taken care of: first, put
        // partially constructed structures into the cache (and functions too,
        // just to make things safe), so that they can be used during their own
        // construction. Second, consider the following situation:
        //
        // struct s* (1) ---> struct s { struct s* x; } ---> struct s* (2)
        //
        // The pointer to "struct s" can only be constructed once the partial
        // type is in the cache. This is only true for the nested pointer in
        // the struct (2), so when construction returns to the first pointer
        // (1), the type has already been constructed (and as a matter of fact
        // must have been). Therefore we first try to lookup the type below,
        // AFTER constructing the nested type and turn off caching, if it is
        // already present.
        
        log::debug << "Building pointer type \"";
        type->print(log::debug);
        log::debug << "\"" << log::end;
        
        // Retrieve the pointers base type in firm.
        const llvm::Type* baseType  = type->getElementType();
        ir_type*          fBaseType = 0;
        
        if (isa<llvm::FunctionType>(baseType))
        {
            // Function pointers are special. We are missing the metadata, to
            // distinguish byval parameters from pointers for example and there
            // is no easy way to retrieve them here.
            // It's not that important for a function pointer though, as it is
            // effectively just used as mode_P value later. For that reason,
            // we stick to an empty metadata structure.
            fBaseType = retrieveFunction(
                cast<llvm::FunctionType>(baseType),
                shared_ptr<FunctionTypeMetakey>(new FunctionTypeMetakey())
            );
        }
        else
        {
            fBaseType = retrieve(baseType);
        }

        assert(fBaseType != 0);
        
        // Check if the pointer has been created by retrieving the base type.
        ir_type* fType = lookup(type);
        
        if (fType != 0)
        {
            doCache = false;
        }
        else
        {
            // Construct an appropriate pointer type.
            fType = new_type_pointer(fBaseType);
        }

        set_type_alignment_bytes(
            fType, context.getTargetData()->getPointerPrefAlignment()
        );
        
        return fType;
    }
    
    /* ====================================================================== */
    /* =                               Arrays                               = */
    /* ====================================================================== */
    
    // [TODO] multidimensional arrays?
    ir_type* TypeBuilder::buildArray(const llvm::ArrayType* type)
    {
        log::debug << "Building array type \"";
        type->print(log::debug);
        log::debug << "\"" << log::end;
        
        // Get the arrays size and element type.
        const llvm::Type* baseType  = type->getElementType();
        ir_type*          fBaseType = retrieve(baseType);
        assert(baseType != 0);
        
        // Construct a firm type. Note that LLVM arrays always have one
        // dimension, but can be nested. Firm supports multidimensional arrays,
        // but we don't use them (at least for now).
        ir_type* fType = new_type_array(1, fBaseType);
        int      size  = static_cast<int>(type->getNumElements());
        
        set_array_bounds_int(fType, 0, 0, size);
        assert((type->getNumElements() <= INT_MAX) && "Array too big");
        
        // Set the arrays size and layout.
        int baseTypeSize = get_type_size_bytes(fBaseType);
        int typeSize     = baseTypeSize * size;
        
        set_type_size_bytes(fType, typeSize);
        set_type_state(fType, layout_fixed);
        set_type_alignment_bytes(
            fType, context.getTargetData()->getPrefTypeAlignment(type)
        );
        
        return fType;
    }
    
    /* ====================================================================== */
    /* =                             Structures                             = */
    /* ====================================================================== */
    
    // [TODO] packed struct
    // [XXX]  alignment is okay?
    ir_type* TypeBuilder::buildStruct(const llvm::StructType* type,
        bool& doCache, const std::string& name)
    {
        // Create a firm struct.
        ident*   typeId = (name != "") ? createIdentifier(name) :
                                         createIdentifier(type);
        ir_type* fType  = new_type_struct(typeId);

        // This is needed for recursive data structures. See the lengthy
        // comment in buildPointer() for details.
        cacheInsert(type, fType);
        doCache = false; // Turn off caching the result.
        
        // Use LLVMs structure layout.
        const llvm::StructLayout* layout = context.
            getTargetData()->getStructLayout(type);
        
        // Iterate the structs fields.
        for (unsigned int i = 0; i < type->getNumContainedTypes(); i++)
        {
            // Create an entry for the field.
            const llvm::Type* fieldType  = type->getContainedType(i);
            ident*            fieldId    = createIdentifier("field", i);
            ir_type*          fFieldType = retrieve(fieldType);
            ir_entity*        entity     = new_entity(fType, fieldId, fFieldType);
            
            // Determine the fields alignment.
            unsigned int alignment = 1;
            if (!type->isPacked())
            {
                alignment = context.getTargetData()->
                    getABITypeAlignment(fieldType);
            }
            
            // Set alignment and offset.
            set_entity_alignment(entity, alignment);
            set_entity_offset(entity, layout->getElementOffset(i));
        }

        // Set the size of the final struct.
        set_type_size_bytes(fType, layout->getSizeInBytes());
        set_type_alignment_bytes(fType, layout->getAlignment());
        set_type_state(fType, layout_fixed);

        return fType;
    }
    
    /* ====================================================================== */
    /* =                           Function types                           = */
    /* ====================================================================== */
    
    ir_type* TypeBuilder::buildFunction(const llvm::FunctionType* type,
        shared_ptr<FunctionTypeMetakey> metadata, bool& doCache)
    {
        assert(metadata.get() != 0);

        bool hasMetadata = (metadata->getNumVariadicParams() > 0) ||
                           (metadata->getNumByValIndices() > 0) ||
                           (metadata->getCallingConvention() != llvm::CallingConv::C);
        
        std::ostringstream nameStr;
        type->print(nameStr);
        log::debug << "Building function type \"" << nameStr.str() << "\"" <<
            (hasMetadata ? " (metadata)" : "") << log::end;
        
        // Retrieve the return type.
        unsigned int      retCount   = 1;
        const llvm::Type* retType    = type->getReturnType();
        unsigned int      paramCount = type->getNumParams() +
                                       metadata->getNumVariadicParams();
        
        if (retType->getTypeID() == llvm::Type::VoidTyID)
        {
            retCount = 0; // Void returns simply don't exist.
        }
        
        // Create the actual function type.
        ir_type* fType = new_type_method(paramCount, retCount);

        // This is needed for recursive data structures. See the lengthy
        // comment in buildPointer() for details.
        cacheInsert(type, metadata, fType);
        doCache = false; // Turn off caching the result.
        
        // Set the return value.
        if (retCount > 0)
        {
            ir_type* fRetType = retrieve(retType);
            set_method_res_type(fType, 0, fRetType);
        }
        
        // Retrieve the parameter types and assign them to the method type.
        for (unsigned int i = 0; i < paramCount; i++)
        {
            int vi = i - type->getNumParams();
            
            // Get the parameter to use here.
            const llvm::Type* paramType = (vi >= 0) ?
                metadata -> getVariadicParam(vi) :
                type     -> getParamType(i);

            // Is the parameter supposed to be passed by value?
            if (metadata->isByValIndex(i))
            {
                assert(isa<llvm::PointerType>(paramType) &&
                    "Non-pointer with byval attribute");

                // Use the base type as parameter in firm.
                paramType = cast<llvm::PointerType>(paramType)->getElementType();
            }
            
            ir_type* fParamType = retrieve(paramType);
            set_method_param_type(fType, i, fParamType);
        } 
        
        // Variadic functions. Just set the appropriate flag.
        if (type->isVarArg())
        {
            log::debug << "Using variadic function type" << log::end;
            set_method_variadicity(fType, variadicity_variadic);
        }
        
        unsigned callingConvention = 0;
        
        // Try to convert the calling convention.
        switch (metadata->getCallingConvention())
        {
        // Not sure about cold. Use the default cdecl.
        case llvm::CallingConv::C:
        case llvm::CallingConv::Cold:
            callingConvention = cc_cdecl_set;
            break;
        
        case llvm::CallingConv::Fast:
        case llvm::CallingConv::X86_FastCall:
            callingConvention = cc_fastcall_set;
            break;
            
        case llvm::CallingConv::X86_StdCall:
            callingConvention = cc_stdcall_set;
            break;
            
        default:
            throw NotSupportedException("Unsupported calling convention");
        }
        
        set_method_calling_convention(fType, callingConvention);

        return fType;
    }
    
    /* ====================================================================== */
    /* =                          Utility methods                           = */
    /* ====================================================================== */
    
    ident* TypeBuilder::createIdentifier(const std::string& name)
    {
        std::string nameCopy(name);        
        str::remove(nameCopy, ' ');
        str::replace(nameCopy, '\\', '^'); // ycomp really doesn't like this.

        // Shorten long type names. ycomp doesn't like them.
        if (nameCopy.size() > maxTypeNameLength)
        {
            std::ostringstream suffixStr;
            suffixStr << "#" << uniqueCounter;
            uniqueCounter++;
            
            str::shorten(nameCopy, maxTypeNameLength - suffixStr.str().size());
            nameCopy.append(suffixStr.str());
        }
        
        return new_id_from_str(nameCopy.c_str());
    }
    
    ident* TypeBuilder::createIdentifier(const std::string& prefix, int counter)
    {
        std::ostringstream idStr;
        idStr << prefix << "#" << counter;
        return createIdentifier(idStr.str());
    }
    
    ident* TypeBuilder::createIdentifier(const llvm::Type* type,
        const std::string& suffix)
    {
        assert(type != 0);
        
        // Create a firm identifier for the given LLVM type.
        std::ostringstream idStr;
        type->print(idStr);
        idStr << suffix;
        
        return createIdentifier(idStr.str());
    }
}
