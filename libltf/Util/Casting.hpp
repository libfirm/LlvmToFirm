#ifndef LTF_UTIL_CASTING_HPP_
#define LTF_UTIL_CASTING_HPP_

#include <libfirm/firm_types.h>

// In order to handle all those special cases without lots of scattered if-
// blocks and type checks, we break LLVM operations down into several operations
// that handle different special types. From these specialized operations we
// build more complex and general any-casts.
//
// Although this will increase source code size, because of the numerous
// functions needed, it will greatly reduce the complexity of those conversion
// functions, making them easier to maintain and modify independently. Also it
// enables strict mode correctness assertions for all cases (actually most of
// the code bloat is due to assertions).
//
// See the possible cast sections below, that describe what types are either
// supported or produced by the different casts. A mod result means, that the
// proper modulo result can be obtained, by cutting of an according number of
// high-order bits (or rather by not interpreting them).

namespace llvm
{
    class Type;
}

namespace ltf
{
    // Bool-cast
    namespace bc
    {
        // Casts from or to mode_b (interpreted as LLVMs i1). Extension and
        // truncation functions have a broader range than usual, making them
        // capable of replacing sitofp, uitofp, inttoptr and ptrtoint.
        // Note that extension to b or truncation from b is not supported,
        // because there are no ints smaller than i1.
        //
        // Cast descriptions:
        //   SExt:  Sign-extend b to int/fp     (sext, sitofp)
        //   ZExt:  Zero-extend b to int/fp/ptr (zext, uitofp, inttoptr)
        //   trunc: Truncate int/ptr to b       (trunc, ptrtoint)
        //
        // Possible casts:
        //   SExt:   b         -> int | mod | fp
        //   ZExt:   b         -> int | mod | fp | ptr
        //   trunc:  int | ptr -> b
        //   FPToSI: fp        -> b
        //   FPToUI: fp        -> b
        //
        ir_node* SExt   (ir_node* node, ir_mode* dstMode);
        ir_node* ZExt   (ir_node* node, ir_mode* dstMode);
        ir_node* trunc  (ir_node* node);
        ir_node* FPToSI (ir_node* node);
        ir_node* FPToUI (ir_node* node);
    }
    
    // Modulo-cast
    namespace mc
    {
        // Modulo-related casts, that can be used, to adapt other casts to
        // modulo types, by normalizing their upper bits etc. The bit width has
        // to be specified along with the modes. The bit width has to be greater
        // than zero and smaller than the modes bit width.
        //
        // Possible casts:
        //   ZNorm:  mod -> int | mod
        //   SNorm:  mod -> int | mod
        //
        // Cast descriptions:
        //   ZNorm: zero-normalize unused upper bits
        //   SNorm: sign-normalize unused upper bits
        //
        ir_node* ZNorm (ir_node* node, unsigned width);
        ir_node* SNorm (ir_node* node, unsigned width);
    }
    
    // Firm-cast
    namespace fc
    {
        // Casts that firm can directly handle without the help of other nodes.
        // These basically produce some conv nodes with some added assertions,
        // to ensure correctness.
        //
        // Possible casts:
        //   SExt:     int       -> int | mod
        //   ZExt:     int       -> int | mod
        //   trunc:    int | mod -> int | mod
        //   SIToFP:   int       -> fp
        //   UIToFP:   int       -> fp
        //   FPToSI:   fp        -> int (mod can't simply be cut off)
        //   FPToUI:   fp        -> int (mod can't simply be cut off)
        //   FPExt:    fp        -> fp
        //   FPTrunc:  fp        -> fp
        //   PtrToInt: ptr       -> int | mod
        //   IntToPtr: int       -> ptr
        //
        ir_node* SExt     (ir_node* node, ir_mode* dstMode);
        ir_node* ZExt     (ir_node* node, ir_mode* dstMode);
        ir_node* trunc    (ir_node* node, ir_mode* dstMode);
        ir_node* SIToFP   (ir_node* node, ir_mode* dstMode);
        ir_node* UIToFP   (ir_node* node, ir_mode* dstMode);
        ir_node* FPToSI   (ir_node* node, ir_mode* dstMode);
        ir_node* FPToUI   (ir_node* node, ir_mode* dstMode);
        ir_node* FPExt    (ir_node* node, ir_mode* dstMode);
        ir_node* FPTrunc  (ir_node* node, ir_mode* dstMode);
        ir_node* ptrToInt (ir_node* node, ir_mode* dstMode);
        ir_node* intToPtr (ir_node* node);
    }
    
    // Any-cast
    namespace ac
    {
        // Casts, that combine multiple specialized casts, to support a wider
        // range of input and output types. If the bit width passed with a mode
        // is greater than zero, the mode is interpreted as modulo type.
        // Note that "integral" types in LLVM translate to either one of int,
        // mod or b. So it's important to have casts that can handle them all
        // in a uniform way.
        // The bit width can either be zero or the related modes width, to turn
        // off modulo handling.
        //
        // Possible casts:
        //   SExt:     int | mod | b -> int | mod
        //   ZExt:     int | mod | b -> int | mod
        //   trunc:    int | mod     -> int | mod | b
        //   SIToFP:   int | mod | b -> fp
        //   UIToFP:   int | mod | b -> fp
        //   FPToSI:   fp            -> int | mod | b
        //   FPToUI:   fp            -> int | mod | b
        //   FPExt:    fp            -> fp
        //   FPTrunc:  fp            -> fp
        //   PtrToInt: ptr           -> int | mod | b
        //   IntToPtr: int | mod | b -> ptr
        //
        ir_node* SExt     (ir_node* node, unsigned srcWidth, ir_mode* dstMode);
        ir_node* ZExt     (ir_node* node, unsigned srcWidth, ir_mode* dstMode);
        ir_node* trunc    (ir_node* node, ir_mode* dstMode);
        ir_node* SIToFP   (ir_node* node, unsigned srcWidth, ir_mode* dstMode);
        ir_node* UIToFP   (ir_node* node, unsigned srcWidth, ir_mode* dstMode);
        ir_node* FPToSI   (ir_node* node, ir_mode* dstMode);
        ir_node* FPToUI   (ir_node* node, ir_mode* dstMode);
        ir_node* FPExt    (ir_node* node, ir_mode* dstMode);
        ir_node* FPTrunc  (ir_node* node, ir_mode* dstMode);
        ir_node* ptrToInt (ir_node* node, ir_mode* dstMode, unsigned dstWidth);
        ir_node* intToPtr (ir_node* node, unsigned srcWidth);
    
        // Type-keeping mode conversions. These convert between different modes
        // that the same LLVM type may use in firm. Base conversions usually
        // normalize the value, using zero-normalization for unsigned and sign-
        // normalization for signed conversions (even if the mode stays the
        // same). This can be turned off with the boolean parameter, if the
        // value is either guaranteed to be already normalized, or if it isn't
        // important for further usage.
        // The square brackets below denote the type checks in TypeInfo.hpp.
        //
        // Possible casts:
        //   boolToB:      [b]    -> b
        //   boolToSBase:  [b]    -> int | mod
        //   boolToUBase:  [b]    -> int | mod
        //   intToSBase:   [int]  -> int | mod
        //   intToUBase:   [int]  -> int | mod
        //   anyToBase:    [atom] -> int | mod | fp | ptr
        //   intToBaseOrB: [int]  -> int | mod | b
        //
        ir_node* boolToB      (const llvm::Type* type, ir_node* node);
        ir_node* boolToSBase  (const llvm::Type* type, ir_node* node, bool normalize = true);
        ir_node* boolToUBase  (const llvm::Type* type, ir_node* node, bool normalize = true);
        ir_node* intToSBase   (const llvm::Type* type, ir_node* node, bool normalize = true);
        ir_node* intToUBase   (const llvm::Type* type, ir_node* node, bool normalize = true);
        ir_node* atomToBase   (const llvm::Type* type, ir_node* node, bool normalize = true);
        ir_node* intToBaseOrB (const llvm::Type* type, ir_node* node);
    }
}

#endif /* LTF_UTIL_CASTING_HPP_ */
