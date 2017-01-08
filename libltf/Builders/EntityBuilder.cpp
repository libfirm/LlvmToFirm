#include "EntityBuilder.hpp"

#include <string>
#include <climits>
#include <cassert>
#include <sstream>
#include <llvm/Module.h>
#include <llvm/Support/Casting.h>
#include <llvm/Support/Mangler.h>
#include <llvm/Type.h>
#include <llvm/DerivedTypes.h>
#include <llvm/Function.h>
#include <llvm/GlobalVariable.h>
#include <llvm/Constants.h>
#include <llvm/Target/TargetData.h>
#include <libfirm/firm.h>
#include "../Util/Logging.hpp"
#include "../Util/LlvmTools.hpp"
#include "../Util/TypeInfo.hpp"
#include "../RAII/GraphScope.hpp"
#include "../Builders/NodeBuilder.hpp"
#include "../Builders/TypeBuilder.hpp"
#include "../Context.hpp"
#include "../Util/Casting.hpp"
#include "../Exceptions/NotSupportedException.hpp"
#include "../Exceptions/NotImplementedException.hpp"
using namespace boost;
using llvm::isa;
using llvm::cast;
using llvm::dyn_cast;

namespace ltf
{
    // Create a node builder for the const graph.
    EntityBuilder::EntityBuilder(Context& context)
        : context(context), nodeBuilder(new NodeBuilder(context)) { }
    
    /* ====================================================================== */
    /* =                         Build entry point                          = */
    /* ====================================================================== */
    
    // [TODO] global alias needed?
    ir_entity* EntityBuilder::doBuild(const llvm::GlobalValue* value,
        bool& doCacheValue)
    {
        // Find the appropriate build method.
        if (isa<llvm::Function>(value))
        {
            return buildFunction(cast<llvm::Function>(value));
        }
        else if (isa<llvm::GlobalVariable>(value))
        {
            return buildVariable(cast<llvm::GlobalVariable>(value), doCacheValue);
        }

        std::ostringstream errorStream;
        errorStream << "Unsupported global value \"";
        value->print(errorStream);
        errorStream << "\"";
        
        throw NotImplementedException(errorStream.str());
    }

    /* ====================================================================== */
    /* =                             Functions                              = */
    /* ====================================================================== */
    
    // [TODO] visibility?, calling convention, parameter attributes,
    //        function attributes
    ir_entity* EntityBuilder::buildFunction(const llvm::Function* function)
    {
        if (function->isIntrinsic())
        {
            throw NotImplementedException("Unimplemented intrinsic function");
        }

        const llvm::FunctionType* functionType = function->getFunctionType();
        assert(functionType != 0);
        
        std::string mangledName = context.mangle(function);
        log::info << "Building function \"" << mangledName << "\" (decl)" << log::end;
        
        // Retrieve the function type.
        shared_ptr<FunctionTypeMetakey> metadata(new FunctionTypeMetakey());
        metadata->addAttributes(function->getAttributes());
        metadata->setCallingConvention(function->getCallingConv());

        ir_type* firmFunctionType = context.getTypeBuilder()->
            retrieveFunction(functionType, metadata);

        // Create an entity for the function inside the global type as
        // LLVM has no notion of classes anymore. Use the mangled name.
        ident* functionEntityId = new_id_from_str(mangledName.c_str());
        
        ir_entity* functionEntity = new_entity(get_glob_type(),
            functionEntityId, firmFunctionType);      
        set_entity_ld_ident(functionEntity, functionEntityId);

        // Apply the correct linkage.
        applyLinkage(function, functionEntity);

        return functionEntity;
    }
    
    /* ====================================================================== */
    /* =                             Variables                              = */
    /* ====================================================================== */

    // [TODO] alignment, address spaces?, sections?
    ir_entity* EntityBuilder::buildVariable(const llvm::GlobalVariable* variable,
        bool& doCache)
    {
        // Constructors and destructors are indicated by the variable name.
        // They are required for C++ support, but can also occur for usual C,
        // when appropriate attributes are used.
        if ((variable->getNameStr() == "llvm.global_ctors") ||
            (variable->getNameStr() == "llvm.global_dtors"))
        {
            return buildCtorDtor(variable);
        }
        
        const llvm::PointerType* ptrType     = variable->getType();
        const llvm::Type*        type        = ptrType->getElementType();
        std::string              mangledName = context.mangle(variable);

        log::info << "Building variable \"" << mangledName << "\"" << log::end;

        // Determine the segment type to use. Default to the global type.
        ir_type* segmentType = get_glob_type();
        
        if (variable->isThreadLocal())
        {
            // [TODO] Using SymConst to refer to those variables won't work.
            //        See cparsers output graph.
            log::debug << "Thread local variable" << log::end;
            segmentType = get_segment_type(IR_SEGMENT_THREAD_LOCAL);
        }

        // Create an entity in the global type.
        ir_type*   fType    = context.retrieveType(type);
        ident*     entityId = new_id_from_str(mangledName.c_str());
        ir_entity* entity   = new_entity(segmentType, entityId, fType);
        
        // Apply LLVM alignment.
        set_entity_alignment(
            entity, context.getTargetData()->getPreferredAlignment(variable)
        );
        
        // Do early cache insertion, since the initializer may trigger building
        // of another entity that in turn may require this one. Imagine two
        // pointers that mutually point to each other.
        cacheInsert(variable, entity);
        doCache = false;
        
        // Some linkage types shouldn't create an initializer, even if LLVM
        // provides one. For example available_externally won't even emit the
        // provided value into the assembler code.
        bool skipInitializer = false;
        
        switch (variable->getLinkage())
        {
        case llvm::GlobalValue::CommonLinkage:
        case llvm::GlobalValue::AvailableExternallyLinkage:
            log::debug << "Skipping initializer due to linkage" << log::end;
            skipInitializer = true;
            break;
        }
        
        bool hasInitializer = false;

        if (!skipInitializer && variable->hasInitializer())
        {
            // It's best to ignore the constant aggregate zero initializer. In
            // that case, data is emitted to the (zero-initialized) bss segment
            // and won't take up space in the binary.
            if (!isa<llvm::ConstantAggregateZero>(variable->getInitializer()))
            {
                if (is_atomic_entity(entity))
                {
                    // Null values won't need an initializer. Emit them to BSS.
                    if (!variable->getInitializer()->isNullValue())
                    {
                        log::debug << "Building atomic initializer" << log::end;
                        
                        // Atomic values can be retrieved directly.
                        // XXX: shouldn't using the entitiy initializer work, too?
                        ir_node* constantNode = buildAtomicInitializer(
                            variable->getInitializer());
                        
                        set_atomic_ent_value(entity, constantNode);
                        hasInitializer = true;
                    }
                }
                else
                {
                    log::debug << "Building compound initializer" << log::end;
                    
                    // For everything else, we need an initializer.
                    set_entity_initializer(entity, buildInitializer(
                        variable->getInitializer()));
                    hasInitializer = true;
                }
            }
        }

        // Needs to be done AFTER setting the initializer.
        applyLinkage(variable, entity);
        set_entity_ld_ident(entity, entityId);
        
        // Enable the constant linkage flag, if possible.
        if (variable->isConstant())
        {
            log::debug << "Setting constant flag" << log::end;

            set_entity_linkage(entity, static_cast<ir_linkage>(
                get_entity_linkage(entity) | IR_LINKAGE_CONSTANT
            ));
        }

        return entity;
    }
    
    ir_entity* EntityBuilder::buildCtorDtor(const llvm::GlobalVariable* variable)
    {
        assert((variable->getNameStr() == "llvm.global_ctors") ||
               (variable->getNameStr() == "llvm.global_dtors"));
        
        // Determine whether this is a ctor or dtor array.
        bool isCtor = (variable->getNameStr() == "llvm.global_ctors");
        
        log::info << "Building " << (isCtor ? "ctor" : "dtor") <<
            " variable" << log::end;

        const llvm::PointerType* ptrType = variable->getType();
        const llvm::ArrayType*   aryType;
        const llvm::StructType*  structType;
        
        // Make sure the variable is a pointer to an array of { i32, void()* }
        // structs with append linkage. The integer denotes priority, but seems
        // not to be in use, even in LLVM. The function pointer is the ctor or
        // dtor function to call. To mimic this in firm, just construct the
        // appropriate function pointer in the appropriate segment.
        aryType = dyn_cast<llvm::ArrayType>(ptrType->getElementType());
        assert((aryType != 0) && "Invalid ctor/dtor variable");
        
        structType = dyn_cast<llvm::StructType>(aryType->getElementType());
        assert((structType != 0) && "Invalid ctor/dtor variable");
        
        assert(
            (structType->getNumElements() == 2) &&
            isa<llvm::IntegerType>(structType->getElementType(0)) &&
            isa<llvm::PointerType>(structType->getElementType(1)) &&
            "Invalid ctor/dtor variable"
        );
        
        assert(
            variable->hasInitializer() && (variable->getLinkage() == llvm::
            GlobalVariable::AppendingLinkage) && "Invalid ctor/dtor variable"
        );
        
        // Determine the segment, to place the function pointers in.
        ir_type* segmentType = get_segment_type(
            isCtor ? IR_SEGMENT_CONSTRUCTORS : IR_SEGMENT_DESTRUCTORS
        );
                
        // Recurse through the initializer array.
        llvm::ConstantArray* arrayConstant = cast<llvm::ConstantArray>(
            variable->getInitializer()
        );
        
        unsigned int counter = 0;
        
        for (unsigned int i = 0; i < arrayConstant->getNumOperands(); i++)
        {
            // Retrieve the ctor / dtor function to call.
            llvm::ConstantStruct* structConstant = cast<llvm::ConstantStruct>(
                arrayConstant->getOperand(i)
            );
            
            llvm::Function* functionPtr = cast<llvm::Function>(
                structConstant->getOperand(1)
            );

            // Find an name that isn't used by another entity.
            std::ostringstream nameStr, firmNameStr;
            
            do
            {
                // Firm will prepend Constructors_ or Destructors_, so in
                // order to find name clashes, compare the firm name, but use
                // the actual name on construction.
                nameStr.str("");
                firmNameStr.str("");
                
                nameStr     << (isCtor ? "ctor" : "dtor") << "_" << counter;
                firmNameStr << (isCtor ? "Constructors_" : "Destructors_")
                            << nameStr.str();
                
                if (counter == UINT_MAX)
                {
                    throw NotSupportedException("Could't find a free name");
                }
                
                counter++;
            }
            while (context.getModule()->getGlobalVariable(firmNameStr.str()) != 0);

            // Build a pointer entity and initialize it.
            ident*     ptrId     = new_id_from_str(nameStr.str().c_str());
            ir_type*   ptrType   = context.retrieveType(functionPtr->getType());
            ir_entity* ptrEntity = new_entity(segmentType, ptrId, ptrType);
            ir_node*   ptrNode   = buildAtomicInitializer(functionPtr);
            
            // Put the pointers together with no additional alignment. Otherwise,
            // the code running the constructors will stumble across the empty
            // bits, trying to call them and crash with a segfault.
            set_entity_alignment(ptrEntity, 1);
            set_entity_visibility(ptrEntity, ir_visibility_local);
            set_atomic_ent_value(ptrEntity, ptrNode);
            set_entity_ld_ident(ptrEntity, new_id_from_str(""));
            add_entity_linkage(ptrEntity, IR_LINKAGE_HIDDEN_USER);
        }
        
        return 0;
    }
    
    ir_node* EntityBuilder::buildAtomicInitializer(const llvm::Constant* constant)
    {
        // Retrieve and cast to the base mode.
        ir_node* node = nodeBuilder->retrieve(constant);
        node = ac::atomToBase(constant->getType(), node);
        
        return node;
    }
    
    ir_initializer_t* EntityBuilder::buildInitializer(const llvm::Constant* constant)
    {
        // Temporarily switch to the const code graph for create_initializer_const.
        GraphScope scope(get_const_code_irg());
        
        // We can't use the NodeBuilder, to obtain a value for the complex
        // constants, because a node in firm can only return atomic values.
        // That means, we have to convert the complex structure into a compound
        // initializer here and delegate construction of atomic values that make
        // up the constant to the NodeBuilder. Note that complex constants can
        // be nested (array of structs etc.).
        if (isa<llvm::ConstantAggregateZero>(constant))
        {
            log::debug << "Building zero initializer" << log::end;
            
            // Use the null initializer for the whole entity. Note that this is
            // only used, for a part of a bigger construct. See buildVariable()
            // for those cases that initialize the whole structure to zero.
            return get_initializer_null();
        }
        else if (ti::isTuple(constant->getType()))
        {
            log::debug << "Building tuple initializer" << log::end;
            
            // Note that LLVMs multi-dimensional arrays are supported, as they
            // are just nested arrays. For example [4 x [4 x float]] is an array
            // containing 4 arrays, each with a length of 16 bytes. So in
            // essentially it's a just a chunk of memory with 64 bytes and not
            // just an array of pointers.
            unsigned int      size        = ti::getTupleSize(constant->getType());
            ir_initializer_t* initializer = create_initializer_compound(size);

            for (unsigned int i = 0; i < size; i++)
            {
                // Recurse and set the result as element value.
                set_initializer_compound_value(
                    initializer, i, buildInitializer(ti::getTupleEntry(constant, i))
                );
            }
            
            return initializer;
        }

        // Seems to be no complex constant. This can happen during recursion.
        // Use the node builder and create a const initializer.
        ir_node* constantNode = buildAtomicInitializer(constant);
        return create_initializer_const(constantNode);
    }
    
    /* ====================================================================== */
    /* =                          Utility methods                           = */
    /* ====================================================================== */

    // [TODO] half of the linkage types are unsupported
    void EntityBuilder::applyLinkage(const llvm::GlobalValue* value, ir_entity* entity)
    {
        bool isConstant = false;
        
        // Variables may be constant.
        if (llvm::isa<llvm::GlobalVariable>(value))
        {
            isConstant = llvm::cast<llvm::GlobalVariable>(value)->isConstant();
        }
        
        // All globals here are static. Set default linkage first.
        set_entity_allocation(entity, allocation_static);
        set_entity_linkage(entity, IR_LINKAGE_DEFAULT);

        switch (value->getLinkage())
        {
        case llvm::GlobalValue::PrivateLinkage:
            // Make the entity local to the translation unit. It is not visible
            // elsewhere, so aggressive optimizations may be turned on.
            log::debug << "Private linkage" << log::end;
            
            set_entity_visibility(entity, ir_visibility_private);
            break;
            
        case llvm::GlobalValue::InternalLinkage:
            // Almost the same as private, but symbols should be visible to
            // debugger and linker.
            log::debug << "Internal linkage" << log::end;
            
            set_entity_visibility(entity, ir_visibility_local);
            break;

        case llvm::GlobalValue::LinkerPrivateLinkage:
            log::debug << "Linker-private linkage" << log::end;
            
            // Local and weak. The linker will remove the symbol in the end, but
            // it is being merged with other symbols before.
            set_entity_visibility(entity, ir_visibility_local);

            // LLVM handles linker private constants in BSS as usual, but
            // emits weak for initialized ones.
            set_entity_linkage(entity, IR_LINKAGE_GARBAGE_COLLECT);
            break;
            
        case llvm::GlobalValue::CommonLinkage:
            // Do not remove these entities and merge them with other entities
            // of the same name at link time.
            log::debug << "Common linkage" << log::end;
            
            // Make the entity visible, enable merging.
            set_entity_visibility(entity, ir_visibility_default);
            set_entity_linkage(entity, IR_LINKAGE_MERGE);
            break;
            
        case llvm::GlobalValue::AvailableExternallyLinkage:
            // For functions, it is like linkonce_odr, but with the ability to
            // throw the function code away at any time (that is because an
            // external copy is guaranteed to be around). This is just there to
            // provide inlining. Since firm currently doesn't allow inlining
            // linkonce functions, we just link this as external function and
            // ignore it when iterating the functions to construct later.
            // For variable this is equivalent to external linkage anyhow.
            log::debug << "Available-externally linkage" << log::end;
            
            set_entity_visibility(entity, ir_visibility_external);
            break;
            
        case llvm::GlobalValue::LinkOnceAnyLinkage:
        case llvm::GlobalValue::LinkOnceODRLinkage:
            // Basically these can occur in multiple translation units and will
            // allow the entity to be merged with other definition at link-time.
            // All of these may be removed, when they aren't being referenced.
            //
            // - LinkOnceAny allows the definitions to differ, so the strongest
            //   definition will be used by the linker, but functions can't be
            //   inlined, because the function that is used is only known by the
            //   linker. This is firms default mode.
            //
            // - LinkOnceODR is used, when all definitions are equal. This will
            //   allow inlining to take place and may be supported by firm soon,
            //   as additional entity property. In the meantime using the above
            //   LinkOnceAny is a safe bet.
            log::debug << "Linkonce-style linkage" << log::end;

            // Use default visibility (defined here, but visible elsewhere).
            set_entity_visibility(entity, ir_visibility_default);
            
            // The entity can be removed at will and is merged with other
            // entities of the same name at link-time.
            set_entity_linkage(entity, static_cast<ir_linkage>(
                IR_LINKAGE_GARBAGE_COLLECT | IR_LINKAGE_MERGE
            ));
            break;
            
        case llvm::GlobalValue::WeakAnyLinkage:
        case llvm::GlobalValue::WeakODRLinkage:
            // These are similar to the linkonce linkages, but unused symbols
            // may not be discarded.
            log::debug << "Weak-style linkage" << log::end;

            set_entity_visibility(entity, ir_visibility_default);
            set_entity_linkage(entity, IR_LINKAGE_WEAK);
            break;
            
        case llvm::GlobalValue::ExternalWeakLinkage:
            // A weak symbol without a definition here. Is merged with other
            // entities of the same name and becomes null if there are no other
            // entities that can be used.
            log::debug << "Extern weak linkage" << log::end;
            
            set_entity_visibility(entity, ir_visibility_external);
            set_entity_linkage(entity, IR_LINKAGE_WEAK);
            break;
            
        case llvm::GlobalValue::ExternalLinkage:
            // This is either a function that is defined elsewhere, but can be
            // accesses here, or it is visible externally, but defined here,
            // depending on whether this is a declaration or definition.
            if (value->isDeclaration())
            {
                log::debug << "External linkage (defined elsewhere)" << log::end;
                set_entity_visibility(entity, ir_visibility_external);
            }
            else
            {
                log::debug << "External linkage (defined here)" << log::end;
                set_entity_visibility(entity, ir_visibility_default);
            }
            break;
            
        case llvm::GlobalValue::AppendingLinkage:
            // Appends two arrays during linkage. This is used by ctor/dtor
            // handling and shouldn't occur for usual entities.            
            throw NotSupportedException("Unsupported linkage \"appending\"");
            
        default:
            throw NotSupportedException("Unsupported linkage");
        }
    }
}
