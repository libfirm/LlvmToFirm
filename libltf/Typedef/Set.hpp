#ifndef LTF_TD_SET_HPP_
#define LTF_TD_SET_HPP_

#include <boost/unordered_set.hpp>
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
    typedef boost::unordered_set<int>          IntSet;
    typedef boost::unordered_set<unsigned int> UIntSet;
    
    typedef IntSet::iterator  IntSetIt;
    typedef UIntSet::iterator UIntSetIt;
 
    // Firm-sets.
    typedef boost::unordered_set<ir_node*> NodeSet;
    typedef boost::unordered_set<ir_mode*> ModeSet;
    typedef boost::unordered_set<ir_type*> FTypeSet;
    
    typedef NodeSet::iterator  NodeSetIt;
    typedef ModeSet::iterator  ModeSetIt;
    typedef FTypeSet::iterator FTypeSetIt;
    
    // LLVM-sets. Note that const is usually used here.
    typedef boost::unordered_set<llvm::Value*>            ValueSet;
    typedef boost::unordered_set<llvm::Instruction*>      InstSet;
    typedef boost::unordered_set<const llvm::Type*>       TypeSet;
    typedef boost::unordered_set<const llvm::BasicBlock*> BlockSet;
    
    typedef ValueSet::iterator ValueSetIt;
    typedef TypeSet::iterator  TypeSetIt;
    typedef InstSet::iterator  InstSetIt;
    typedef BlockSet::iterator BlockSetIt;
}

#endif /* LTF_TD_SET_HPP_ */
