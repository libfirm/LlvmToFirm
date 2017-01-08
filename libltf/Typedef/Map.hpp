#ifndef LTF_TD_MAP_HPP_
#define LTF_TD_MAP_HPP_

#include <utility>
#include <boost/unordered_map.hpp>
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
    // LLVM/Firm-sets.
    typedef boost::unordered_map<ir_node*, llvm::Value*>            NodeToValueMap;
    typedef boost::unordered_map<ir_node*, llvm::Instruction*>      NodeToInstMap;
    typedef boost::unordered_map<ir_type*, const llvm::Type*>       FTypeToTypeMap;
    typedef boost::unordered_map<ir_node*, const llvm::BasicBlock*> NodeToBlockMap;
    
    typedef std::pair<ir_node*, llvm::Value*>            NodeValuePair;
    typedef std::pair<ir_node*, llvm::Instruction*>      NodeInstPair;
    typedef std::pair<ir_type*, const llvm::Type*>       FTypeTypePair;
    typedef std::pair<ir_node*, const llvm::BasicBlock*> NodeBlockPair;

    typedef NodeToValueMap::iterator  NodeToValueMapIt;
    typedef NodeToInstMap::iterator   NodeToInstMapIt;
    typedef FTypeToTypeMap::iterator  FTypeToTypeMapIt;
    typedef NodeToBlockMap::iterator  NodeToBlockMapIt;
    
    typedef boost::unordered_map<llvm::Value*, ir_node*>            ValueToNodeMap;
    typedef boost::unordered_map<llvm::Instruction*, ir_node*>      InstToNodeMap;
    typedef boost::unordered_map<const llvm::Type*, ir_type*>       TypeToFTypeMap;
    typedef boost::unordered_map<const llvm::Type*, ir_mode*>       TypeToModeMap;
    typedef boost::unordered_map<const llvm::BasicBlock*, ir_node*> BlockToNodeMap;
    
    typedef std::pair<llvm::Value*, ir_node*>            ValueNodePair;
    typedef std::pair<llvm::Instruction*, ir_node*>      InstNodePair;
    typedef std::pair<const llvm::Type*, ir_type*>       TypeFTypePair;
    typedef std::pair<const llvm::Type*, ir_mode*>       TypeModePair;
    typedef std::pair<const llvm::BasicBlock*, ir_node*> BlockNodePair;
    
    typedef ValueToNodeMap::iterator ValueToNodeMapIt;
    typedef InstToNodeMap::iterator  InstToNodeMapIt;
    typedef TypeToFTypeMap::iterator TypeToFTypeMapIt;
    typedef TypeToModeMap::iterator  TypeToModeMapIt;
    typedef BlockToNodeMap::iterator BlockToNodeMapIt;
    
    // Self-maps.
    typedef boost::unordered_map<ir_node*, ir_node*> NodeMap;
    typedef boost::unordered_map<ir_mode*, ir_mode*> ModeMap;
    typedef boost::unordered_map<ir_type*, ir_type*> FTypeMap;
    
    typedef std::pair<ir_node*, ir_node*> NodePair;
    typedef std::pair<ir_mode*, ir_mode*> ModePair;
    typedef std::pair<ir_type*, ir_type*> FTypePair;
    
    typedef NodeMap::iterator  NodeMapIt;
    typedef ModeMap::iterator  ModeMapIt;
    typedef FTypeMap::iterator FTypeMapIt;
    
    typedef boost::unordered_map<llvm::Value*, llvm::Value*>                       ValueMap;
    typedef boost::unordered_map<const llvm::Type*, const llvm::Type*>             TypeMap;
    typedef boost::unordered_map<const llvm::BasicBlock*, const llvm::BasicBlock*> BlockMap;
    
    typedef std::pair<llvm::Value*, llvm::Value*>                       ValuePair;
    typedef std::pair<const llvm::Type*, const llvm::Type*>             TypePair;
    typedef std::pair<const llvm::BasicBlock*, const llvm::BasicBlock*> BlockPair;
    
    typedef ValueMap::iterator ValueMapIt;
    typedef TypeMap::iterator  TypeMapIt;
    typedef BlockMap::iterator BlockMapIt;
}

#endif /* LTF_TD_MAP_HPP_ */
