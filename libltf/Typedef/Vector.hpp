#ifndef LTF_TD_VECTOR_HPP_
#define LTF_TD_VECTOR_HPP_

#include <vector>
#include <libfirm/firm_types.h>

namespace llvm
{
    class Value;
    class Type;
    class BasicBlock;
    class Instruction;
}

namespace ltf
{
    typedef std::vector<int>          IntVect;
    typedef std::vector<unsigned int> UIntVect;
    
    typedef IntVect::iterator  IntVectIt;
    typedef UIntVect::iterator UIntVectIt;
 
    // Firm-vectors.
    typedef std::vector<ir_node*> NodeVect;
    typedef std::vector<ir_mode*> ModeVect;
    typedef std::vector<ir_type*> FTypeVect;
    
    typedef NodeVect::iterator  NodeVectIt;
    typedef ModeVect::iterator  ModeVectIt;
    typedef FTypeVect::iterator FTypeVectIt;
    
    // LLVM-vectors.
    typedef std::vector<llvm::Value*>            ValueVect;
    typedef std::vector<llvm::Instruction*>      InstVect;
    typedef std::vector<const llvm::Type*>       TypeVect;
    typedef std::vector<const llvm::BasicBlock*> BlockVect;
    
    typedef ValueVect::iterator ValueVectIt;
    typedef TypeVect::iterator  TypeVectIt;
    typedef InstVect::iterator  InstVectIt;
    typedef BlockVect::iterator BlockVectIt;
}

#endif /* LTF_TD_VECTOR_HPP_ */
