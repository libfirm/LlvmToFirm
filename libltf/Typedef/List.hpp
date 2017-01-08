#ifndef LTF_TD_LIST_HPP_
#define LTF_TD_LIST_HPP_

#include <list>
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
    typedef std::list<int>          IntList;
    typedef std::list<unsigned int> UIntList;
    
    typedef IntList::iterator  IntListIt;
    typedef UIntList::iterator UIntListIt;
 
    // Firm-lists.
    typedef std::list<ir_node*> NodeList;
    typedef std::list<ir_mode*> ModeList;
    typedef std::list<ir_type*> FTypeList;
    
    typedef NodeList::iterator  NodeListIt;
    typedef ModeList::iterator  ModeListIt;
    typedef FTypeList::iterator FTypeListIt;
    
    // LLVM-lists. Note that const is usually used here.
    typedef std::list<llvm::Value*>             ValueList;
    typedef std::list<llvm::Instruction*>       InstList;
    typedef std::list<const llvm::Type*>        TypeList;
    typedef std::list<const llvm::BasicBlock*>  BlockList;
    
    typedef ValueList::iterator ValueListIt;
    typedef BlockList::iterator BlockListIt;
    typedef InstList::iterator  InstListIt;
    typedef TypeList::iterator  TypeListIt;
}

#endif /* LTF_TD_LIST_HPP_ */
