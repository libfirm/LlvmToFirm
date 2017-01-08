#ifndef LTF_BLD_NODE_BUILDER_HPP_
#define LTF_BLD_NODE_BUILDER_HPP_

#include <libfirm/firm_types.h>
#include "Builder.hpp"
#include "TypeBuilder.hpp"
#include "../Typedef/Pointer.hpp"
#include "../Typedef/Vector.hpp"

namespace llvm
{
    class Type;
    class Value;
    class Operator;
    class Instruction;
    class CallInst;
    class ReturnInst;
    class BranchInst;
    class SwitchInst;
    class PHINode;
    class AllocaInst;
    class MallocInst;
    class LoadInst;
    class StoreInst;
    class GEPOperator;
    class ConstantPointerNull;
    class ConstantInt;
    class ConstantFP;
    class ConstantArray;
    class ConstantStruct;
    class Constant;
    class Argument;
    class GlobalValue;
    class UndefValue;
    class UnreachableInst;
    class ExtractValueInst;
    class InsertValueInst;
    class CompositeType;
    class VAArgInst;
}

namespace ltf
{
    struct ConversionFlags
    {
        enum Enum
        {
            None = 0,
            ZeroExtend = 1,
            DontNormalize = 2,
            Normalize = 4
        };
    };

    typedef ConversionFlags::Enum ConversionFlagE;
    
    class Context;
    class FrameBuilder;
    class BlockBuilder;
    
    class NodeBuilder : public Builder<const llvm::Value*, ir_node*>
    {
    private:
        typedef Builder<const llvm::Value*, ir_node*> Base;
        
    public:
        NodeBuilder(Context& context);
        
        NodeBuilder(
            Context& context,
            ir_graph* graph,
            BlockBuilderSPtr blockBuilder,
            FrameBuilderSPtr frameBuilder
        );
        
        using Base::retrieve; // Keep the overloaded retrieve functions.
        
        // Note that nodes returned from retrieve may not have the mode you
        // expect. For example, a i1 value can turn into mode_b, mode_Is1,
        // mode_Iu1, depending on the context. To make sure that the correct
        // type is used, pass the value through convertToMode() with the
        // appropriate mode flags set.
        // As a rule of thumb: always make sure you convert the value to
        // the proper mode. Even if that means calling convertToMode() with
        // default flags.
        ir_node* retrieve(const llvm::Value* value, bool& wasCached);
        ir_node* buildPhi(const llvm::PHINode* inst);
        
    protected:
        ir_node* doBuild(const llvm::Value* value, bool& doCache);
        
    private:
        Context& context;
        ir_graph* graph;
        
        BlockBuilderSPtr blockBuilder;
        FrameBuilderSPtr frameBuilder;
        
        bool isConstGraph();

        /* =========================== Arithmetic =========================== */

        ir_node* buildAdd  (const llvm::Operator* valueOp);
        ir_node* buildSub  (const llvm::Operator* valueOp);
        ir_node* buildMul  (const llvm::Operator* valueOp);
        ir_node* buildDiv  (const llvm::Operator* valueOp, bool isUnsigned);
        ir_node* buildRem  (const llvm::Operator* valueOp, bool isUnsigned);
        ir_node* buildFDiv (const llvm::Operator* valueOp);
        ir_node* buildICmp (const llvm::Operator* valueOp);
        ir_node* buildFCmp (const llvm::Operator* valueOp);
        
        /* ============================ Bitwise ============================= */

        ir_node* buildAnd (const llvm::Operator* valueOp);
        ir_node* buildOr  (const llvm::Operator* valueOp);
        ir_node* buildXor (const llvm::Operator* valueOp);
        ir_node* buildShl (const llvm::Operator* valueOp);
        ir_node* buildShr (const llvm::Operator* valueOp, bool isLogical);
        
        /* ========================== Conversions =========================== */

        ir_node* buildCast     (const llvm::Operator* valueOp, bool zeroExtend);
        ir_node* buildBitCast  (const llvm::Operator* valueOp);
        ir_node* buildZExt     (const llvm::Operator* valueOp);
        ir_node* buildSExt     (const llvm::Operator* valueOp);
        ir_node* buildTrunc    (const llvm::Operator* valueOp);
        ir_node* buildSIToFP   (const llvm::Operator* valueOp);
        ir_node* buildUIToFP   (const llvm::Operator* valueOp);
        ir_node* buildFPToSI   (const llvm::Operator* valueOp);
        ir_node* buildFPToUI   (const llvm::Operator* valueOp);
        ir_node* buildFPExt    (const llvm::Operator* valueOp);
        ir_node* buildFPTrunc  (const llvm::Operator* valueOp);
        ir_node* buildPtrToInt (const llvm::Operator* valueOp);
        ir_node* buildIntToPtr (const llvm::Operator* valueOp);
        
        /* ========================== Control flow ========================== */

        ir_node* buildCall        (const llvm::CallInst*        inst);
        ir_node* buildReturn      (const llvm::ReturnInst*      inst);
        ir_node* buildBranch      (const llvm::BranchInst*      inst);
        ir_node* buildSwitch      (const llvm::SwitchInst*      inst);
        ir_node* buildIfCascade   (const llvm::SwitchInst*      inst);
        ir_node* buildPhiProxy    (const llvm::PHINode*         inst);
        ir_node* buildUnreachable (const llvm::UnreachableInst* inst); 

        /* ============================= Memory ============================= */

        ir_node* buildAlloca (const llvm::AllocaInst*  inst);
        ir_node* buildLoad   (const llvm::LoadInst*    inst);
        ir_node* buildStore  (const llvm::StoreInst*   inst);
        ir_node* buildGetPtr (const llvm::GEPOperator* valueOp);

        ir_node* buildGetPtr(
            ir_node* valueNode,
            const llvm::Type* valueType,
            const ValueVect& indices
        );
        
        /* =========================== Constants ============================ */

        ir_node* buildNullPtr (const llvm::ConstantPointerNull* constant);
        ir_node* buildInteger (const llvm::ConstantInt*         constant);
        ir_node* buildFloat   (const llvm::ConstantFP*          constant);
        ir_node* buildPointer (const llvm::GlobalValue*         constant);
        ir_node* buildUndef   (const llvm::UndefValue*          constant);
        ir_node* buildArray   (const llvm::ConstantArray*       constant);
        ir_node* buildStruct  (const llvm::ConstantStruct*      constant);

        /* ========================= Miscellaneous ========================== */
        
        ir_node* buildArgument (const llvm::Argument* argument);
        ir_node* buildSelect   (const llvm::Operator* valueOp);
        
        /* ===================== Variadic Arguments ===================== */
        
        ir_node* buildVAStart (const llvm::CallInst*  inst);
        ir_node* buildVAEnd   (const llvm::CallInst*  inst);
        ir_node* buildVACopy  (const llvm::CallInst*  inst);
        ir_node* buildVAArg   (const llvm::VAArgInst* inst);
        
        /* =========================== Aggregates =========================== */
        
        ir_node* buildTupleConstant (const llvm::Constant*         constant);
        ir_node* buildTupleUndef    (const llvm::UndefValue*       constant);
        ir_node* buildExtractValue  (const llvm::ExtractValueInst* inst);
        ir_node* buildInsertValue   (const llvm::InsertValueInst*  inst);
        
        // Extract or insert values on aggregate tuples.
        ir_node* buildTupleExtract (ir_node* tuple, const llvm::Type* type,
                                    const UIntVect& indices);
        ir_node* buildTupleInsert  (ir_node* tuple, const llvm::Type* type,
                                    const UIntVect& indices, ir_node* value);
        
        // Memory access (de-)serialization of aggregates in memory.
        ir_node* buildTupleLoad  (ir_node* pointer, const llvm::Type* type);
        void     buildTupleStore (ir_node* tuple, ir_node* pointer,
                                  const llvm::Type* type);
        
        ir_node* buildAggregateAlloc (const llvm::Type* type);
        void     buildAggregateFree  (ir_node* pointer, const llvm::Type* type);
    };
}

#endif /* LTF_BLD_NODE_BUILDER_HPP_ */
