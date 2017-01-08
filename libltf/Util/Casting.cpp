#include "Casting.hpp"

#include <climits>
#include <cassert>
#include <libfirm/firm.h>
#include "TypeInfo.hpp"
#include "../RAII/UnoptimizedScope.hpp"

namespace ltf
{
    /* ====================================================================== */
    /* =                         Utility functions                          = */
    /* ====================================================================== */
    
    namespace
    {
        // Shortcut for a mux with constant values.
        ir_node* buildMux(ir_node* sel, long trueValue,
            long falseValue, ir_mode* mode)
        {
            ir_node* trueNode  = new_Const_long(mode, trueValue);
            ir_node* falseNode = new_Const_long(mode, falseValue);
            return new_Mux(sel, falseNode, trueNode, mode);
        }
        
        // Build a conv node, if it is necessary.
        ir_node* buildConv(ir_node* node, ir_mode* mode)
        {
            if (get_irn_mode(node) == mode) return node;
            return new_Conv(node, mode);
        }
    }
    
    /* ====================================================================== */
    /* =                             Bool-casts                             = */
    /* ====================================================================== */
    
    namespace bc
    {
        // Sign-extend from mode_b. b -> int | mod | fp
        ir_node* SExt(ir_node* node, ir_mode* dstMode)
        {
            assert(get_irn_mode(node) == mode_b);
            assert(mode_is_int(dstMode) || mode_is_float(dstMode));
            
            // A simple mux node will do.
            return buildMux(node, -1L, 0L, dstMode);
        }
        
        // Zero-extend from mode_b. b -> int | mod | fp | ptr
        ir_node* ZExt(ir_node* node, ir_mode* dstMode)
        {
            assert(get_irn_mode(node) == mode_b);
            
            assert(
                mode_is_int(dstMode) ||
                mode_is_float(dstMode) ||
                mode_is_reference(dstMode)
            );
            
            // A simple mux node will do.
            return buildMux(node, 1L, 0L, dstMode);    
        }

        // Truncate to mode_b. int | ptr -> b
        ir_node* trunc(ir_node* node)
        {
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_int(srcMode) || mode_is_reference(srcMode));
            
            // Least significant bit decides.
            ir_node* oneNode  = new_Const_long(srcMode, 1L);
            ir_node* andNode  = new_And(node, oneNode, srcMode);
            ir_node* zeroNode = new_Const_long(srcMode, 0L);
            ir_node* cmpNode  = new_Cmp(andNode, zeroNode);
            return new_Proj(cmpNode, mode_b, pn_Cmp_Lg);
        }
        
        // Floating point to signed mode_b. fp -> b
        ir_node* FPToSI(ir_node* node)
        {
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_float(srcMode));
            
            // -1 is true, (-1, 0] is false. Anything else is undefined.
            ir_node* oneNode = new_Const_long(srcMode, -1L);
            ir_node* cmpNode = new_Cmp(node, oneNode);
            return new_Proj(cmpNode, mode_b, pn_Cmp_Eq);
        }
        
        // Floating point to unsigned mode_b. fp -> b
        ir_node* FPToUI(ir_node* node)
        {
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_float(srcMode));
            
            // 1 is true, [0, 1) is false. Anything else is undefined.
            ir_node* oneNode = new_Const_long(srcMode, 1L);
            ir_node* cmpNode = new_Cmp(node, oneNode);
            return new_Proj(cmpNode, mode_b, pn_Cmp_Eq);
        }
    }
    
    /* ====================================================================== */
    /* =                            Modulo-casts                            = */
    /* ====================================================================== */
    
    namespace mc
    {
        ir_node* ZNorm(ir_node* node, unsigned width)
        {
            ir_mode* mode = get_irn_mode(node);
            assert(width > 0);
            assert(width < get_mode_size_bits(mode));
            assert(width < LONG_BIT);
            
            // Fill all bits with ones and shift in zeroes, so that srcWidth
            // bits remain with a value of one.
            long     mask     = (~0UL) >> (LONG_BIT - width);
            ir_node* maskNode = new_Const_long(mode, mask);
            return new_And(node, maskNode, mode);
        }
        
        ir_node* SNorm(ir_node* node, unsigned width)
        {
            ir_mode* mode = get_irn_mode(node);
            assert(width > 0);
            assert(width < get_mode_size_bits(mode));
            
            // Make the value signed, or the sign-shift won't properly work.
            mode = ti::getSignedMode(mode);
            node = buildConv(node, mode);
            
            // Shift the value to the left, so that the modulo types MSB is the
            // base modes MSB and arithmetically shift back to the right.
            long     shift     = get_mode_size_bits(mode) - width;
            ir_node* shiftNode = new_Const_long(mode_Iu, shift);
            ir_node* shlNode   = new_Shl(node, shiftNode, mode);
            return new_Shrs(shlNode, shiftNode, mode);
        }
    }
    
    /* ====================================================================== */
    /* =                             Firm-casts                             = */
    /* ====================================================================== */
    
    namespace fc
    {
        ir_node* SExt(ir_node* node, ir_mode* dstMode)
        {
            // Make sure this is int -> int and an extension.
            ir_mode* srcMode = get_irn_mode(node);
            
            assert(mode_is_int(srcMode));
            assert(mode_is_int(dstMode));
            assert(get_mode_size_bytes(dstMode) >=
                   get_mode_size_bytes(srcMode));
            
            // Ensure that the source is signed.
            node = buildConv(node, ti::getSignedMode(srcMode));
            return buildConv(node, dstMode);
        }
        
        ir_node* ZExt(ir_node* node, ir_mode* dstMode)
        {
            // Make sure this is int -> int and an extension.
            ir_mode* srcMode = get_irn_mode(node);
            
            assert(mode_is_int(srcMode));
            assert(mode_is_int(dstMode));
            assert(get_mode_size_bytes(dstMode) >=
                   get_mode_size_bytes(srcMode));
            
            // Ensure that the source is unsigned.
            node = buildConv(node, ti::getUnsignedMode(srcMode));
            return buildConv(node, dstMode);
        }
        
        ir_node* trunc(ir_node* node, ir_mode* dstMode)
        {
            // Make sure this is int -> int and a truncation.
            ir_mode* srcMode = get_irn_mode(node);
            
            assert(mode_is_int(srcMode));
            assert(mode_is_int(dstMode));
            assert(get_mode_size_bytes(dstMode) <=
                   get_mode_size_bytes(srcMode));
            
            return buildConv(node, dstMode);
        }
        
        ir_node* SIToFP(ir_node* node, ir_mode* dstMode)
        {
            // Make sure this is int -> fp.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_int(srcMode));
            assert(mode_is_float(dstMode));
            
            // Ensure that the source is signed.
            node = buildConv(node, ti::getSignedMode(srcMode));
            return buildConv(node, dstMode);
        }
        
        ir_node* UIToFP(ir_node* node, ir_mode* dstMode)
        {
            // Make sure this is int -> fp.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_int(srcMode));
            assert(mode_is_float(dstMode));
            
            // Ensure that the source is unsigned.
            node = buildConv(node, ti::getUnsignedMode(srcMode));
            return buildConv(node, dstMode);
        }
        
        ir_node* FPToSI(ir_node* node, ir_mode* dstMode)
        {
            // Make sure this is fp -> int.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_float(srcMode));
            assert(mode_is_int(dstMode));
            
            // Firm may optimize the lower firm mode away.
            UnoptimizedScope scope;
            ir_node* strictConv = new_Conv(node, srcMode);
            set_Conv_strict(strictConv, 1);
            
            // Cast to the signed destination first.
            strictConv = buildConv(strictConv, ti::getSignedMode(dstMode));
            return buildConv(strictConv, dstMode);
        }
        
        ir_node* FPToUI(ir_node* node, ir_mode* dstMode)
        {
            // Make sure this is fp -> int.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_float(srcMode));
            assert(mode_is_int(dstMode));
            
            // Firm may optimize the lower firm mode away.
            UnoptimizedScope scope;
            ir_node* strictConv = new_Conv(node, srcMode);
            set_Conv_strict(strictConv, 1);
            
            // Cast to the unsigned destination first.
            strictConv = buildConv(strictConv, ti::getUnsignedMode(dstMode));
            return buildConv(strictConv, dstMode);
        }
        
        ir_node* FPExt(ir_node* node, ir_mode* dstMode)
        {
            // Make sure this is fp -> fp.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_float(srcMode));
            assert(mode_is_float(dstMode));
            
            // Firm may optimize the lower firm mode away.
            UnoptimizedScope scope;
            ir_node* strictConv = new_Conv(node, srcMode);
            set_Conv_strict(strictConv, 1);
            
            return buildConv(strictConv, dstMode);
        }
        
        ir_node* FPTrunc(ir_node* node, ir_mode* dstMode)
        {
            // Make sure this is fp -> fp.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_float(srcMode));
            assert(mode_is_float(dstMode));
            
            // Set strict, to properly create INF values.
            ir_node* convNode = buildConv(node, dstMode);
            set_Conv_strict(convNode, 1);
            return convNode;
        }
        
        ir_node* ptrToInt(ir_node* node, ir_mode* dstMode)
        {
            // Make sure this is P -> int.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_reference(srcMode));
            assert(mode_is_int(dstMode));
            
            // This should already zero-extend or truncate.
            return buildConv(node, dstMode);
        }
        
        ir_node* intToPtr(ir_node* node)
        {
            // Make sure this is int -> P.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_int(srcMode));
            
            // Ensure that the source is unsigned.
            node = buildConv(node, ti::getUnsignedMode(srcMode));
            return buildConv(node, mode_P);
        }
    }
    
    /* ====================================================================== */
    /* =                             Any-casts                              = */
    /* ====================================================================== */
    
    namespace ac
    {
        ir_node* SExt(ir_node* node, unsigned srcWidth, ir_mode* dstMode)
        {
            // Validate modes.
            ir_mode* srcMode = get_irn_mode(node);
            assert((srcMode == mode_b) || mode_is_int(srcMode));
            assert(mode_is_int(dstMode));
            
            // Delegate bool-casts.
            if (srcMode == mode_b) return bc::SExt(node, dstMode);
            
            // Sign-normalize modulo types and use a firm-cast.
            if ((srcWidth > 0) && (srcWidth < get_mode_size_bits(srcMode)))
            {
                node = mc::SNorm(node, srcWidth);
            }
            
            assert(srcWidth <= get_mode_size_bits(srcMode));
            return fc::SExt(node, dstMode);
        }
        
        ir_node* ZExt(ir_node* node, unsigned srcWidth, ir_mode* dstMode)
        {
            // Validate modes.
            ir_mode* srcMode = get_irn_mode(node);
            assert((srcMode == mode_b) || mode_is_int(srcMode));
            assert(mode_is_int(dstMode));
            
            // Delegate bool-casts.
            if (srcMode == mode_b) return bc::ZExt(node, dstMode);
            
            // Zero-normalize modulo types and use a firm-cast.
            if ((srcWidth > 0) && (srcWidth < get_mode_size_bits(srcMode)))
            {
                node = mc::ZNorm(node, srcWidth);
            }
            
            assert(srcWidth <= get_mode_size_bits(srcMode));
            return fc::ZExt(node, dstMode);
        }
        
        ir_node* trunc(ir_node* node, ir_mode* dstMode)
        {
            // Validate modes.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_int(srcMode));
            assert((dstMode == mode_b) || mode_is_int(dstMode));
            
            // Delegate bool-casts.
            if (dstMode == mode_b) return bc::trunc(node);
            
            // Otherwise use a firm-cast (that's okay for modulo types).
            return fc::trunc(node, dstMode);
        }
        
        ir_node* SIToFP(ir_node* node, unsigned srcWidth, ir_mode* dstMode)
        {
            // Validate modes.
            ir_mode* srcMode = get_irn_mode(node);
            assert((srcMode == mode_b) || mode_is_int(srcMode));
            assert(mode_is_float(dstMode));
            
            // Delegate bool-casts.
            if (srcMode == mode_b) return bc::SExt(node, dstMode);
            
            // Sign-normalize modulo types and use a firm-cast.
            if ((srcWidth > 0) && (srcWidth < get_mode_size_bits(srcMode)))
            {
                node = mc::SNorm(node, srcWidth);
            }
            
            assert(srcWidth <= get_mode_size_bits(srcMode));
            return fc::SIToFP(node, dstMode);
        }
        
        ir_node* UIToFP(ir_node* node, unsigned srcWidth, ir_mode* dstMode)
        {
            // Validate modes.
            ir_mode* srcMode = get_irn_mode(node);
            assert((srcMode == mode_b) || mode_is_int(srcMode));
            assert(mode_is_float(dstMode));
            
            // Delegate bool-casts.
            if (srcMode == mode_b) return bc::ZExt(node, dstMode);
            
            // Zero-normalize modulo types and use a firm-cast.
            if ((srcWidth > 0) && (srcWidth < get_mode_size_bits(srcMode)))
            {            
                node = mc::ZNorm(node, srcWidth);
            }
            
            assert(srcWidth <= get_mode_size_bits(srcMode));
            return fc::UIToFP(node, dstMode);
        }
        
        ir_node* FPToSI(ir_node* node, ir_mode* dstMode)
        {
            // Validate modes.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_float(srcMode));
            assert((dstMode == mode_b) || mode_is_int(dstMode));
            
            // Delegate bool-casts and modulo-casts.
            if (dstMode == mode_b) return bc::FPToSI(node);

            // Handle anything else using a firm-cast. This is also valid for
            // modulo types, because anything that won't fit into the target
            // type is undefined in LLVM.
            return fc::FPToSI(node, dstMode);
        }
        
        ir_node* FPToUI(ir_node* node, ir_mode* dstMode)
        {
            // Validate modes.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_float(srcMode));
            assert((dstMode == mode_b) || mode_is_int(dstMode));
            
            // Delegate bool-casts and modulo-casts.
            if (dstMode == mode_b) return bc::FPToSI(node);

            // Handle anything else using a firm-cast. This is also valid for
            // modulo types, because anything that won't fit into the target
            // type is undefined in LLVM.
            return fc::FPToUI(node, dstMode);
        }
        
        ir_node* FPExt(ir_node* node, ir_mode* dstMode)
        {
            return fc::FPExt(node, dstMode);
        }
        
        ir_node* FPTrunc(ir_node* node, ir_mode* dstMode)
        {
            return fc::FPTrunc(node, dstMode);
        }
        
        ir_node* ptrToInt(ir_node* node, ir_mode* dstMode, unsigned dstWidth)
        {
            // Validate modes.
            ir_mode* srcMode = get_irn_mode(node);
            assert(mode_is_reference(srcMode));
            assert((dstMode == mode_b) || mode_is_int(dstMode));
            
            // Delegate bool-casts.
            if (dstMode == mode_b) return bc::trunc(node);
            
            // Otherwise use a firm-cast (that's okay for modulo types).
            return fc::ptrToInt(node, dstMode);
        }
        
        ir_node* intToPtr(ir_node* node, unsigned srcWidth)
        {
            // Validate modes.
            ir_mode* srcMode = get_irn_mode(node);
            assert((srcMode == mode_b) || mode_is_int(srcMode));
            
            // Delegate bool-casts.
            if (srcMode == mode_b) return bc::ZExt(node, mode_P);
            
            // Zero-normalize modulo types and use a firm-cast.
            if ((srcWidth > 0) && (srcWidth < get_mode_size_bits(srcMode)))
            {
                node = mc::ZNorm(node, srcWidth);
            }
            
            assert(srcWidth <= get_mode_size_bits(srcMode));
            return fc::intToPtr(node);
        }
        
        ir_node* boolToB(const llvm::Type* type, ir_node* node)
        {
            assert(ti::isBool(type)); // b | Bs | Bu
            if (get_irn_mode(node) == mode_b) return node;
            return trunc(node, mode_b);
        }
        
        ir_node* boolToSBase(const llvm::Type* type, ir_node* node, bool normalize)
        {
            assert(ti::isBool(type));
            return intToSBase(type, node, normalize);
        }
        
        ir_node* boolToUBase(const llvm::Type* type, ir_node* node, bool normalize)
        {
            assert(ti::isBool(type));
            return intToUBase(type, node, normalize);
        }

        ir_node* intToSBase(const llvm::Type* type, ir_node* node, bool normalize)
        {
            assert(ti::isInt(type)); // b | int | mod
            ir_mode* srcMode = get_irn_mode(node);
            ir_mode* dstMode = ti::getSignedMode(ti::getBaseMode(type));

            // For a b input, just sign-extend.
            if (srcMode == mode_b) return SExt(node, 1, dstMode);

            // Otherwise, the base should be the same width.
            assert(get_mode_size_bits(srcMode) == get_mode_size_bits(dstMode));
            
            // Normalize modulo types and then cast.
            if (ti::isModInt(type) && normalize)
            {
                node = mc::SNorm(node, ti::getWidth(type));
            }
            return buildConv(node, dstMode);
        }
        
        ir_node* intToUBase(const llvm::Type* type, ir_node* node, bool normalize)
        {
            assert(ti::isInt(type)); // b | int | mod
            ir_mode* srcMode = get_irn_mode(node);
            ir_mode* dstMode = ti::getUnsignedMode(ti::getBaseMode(type));
            
            // For a b input, just zero-extend.
            if (srcMode == mode_b) return ZExt(node, 1, dstMode);
            
            // Otherwise, the base should be the same width.
            assert(get_mode_size_bits(srcMode) == get_mode_size_bits(dstMode));
            
            // Normalize modulo types and then cast.
            if (ti::isModInt(type) && normalize)
            {
                node = mc::ZNorm(node, ti::getWidth(type));
            }
            return buildConv(node, dstMode);
        }
        
        ir_node* atomToBase(const llvm::Type* type, ir_node* node, bool normalize)
        {
            // Excludes tuple types.
            assert(ti::isAtom(type));
            if (ti::isInt(type)) return intToSBase(type, node, normalize);
            
            ir_mode* dstMode = ti::getBaseMode(type);
            return buildConv(node, dstMode);
        }
        
        // Useful for bitwise operations, as those may be applied to mode_b, too.
        // Values are never normalized here.
        ir_node* intToBaseOrB(const llvm::Type* type, ir_node* node)
        {
            if (ti::isBool(type)) return boolToB(type, node);
            return intToSBase(type, node, false);
        }
    }
}
