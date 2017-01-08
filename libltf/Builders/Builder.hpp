#ifndef LTF_BLD_BUILDER_HPP_
#define LTF_BLD_BUILDER_HPP_

#include <cassert>
#include <boost/shared_ptr.hpp>
#include <boost/unordered_map.hpp>
#include <boost/functional/hash.hpp>

namespace ltf
{
    // What's up with the metakey?
    // ---------------------------
    //
    // There are times, where an LLVM object just doesn't suffice, to construct
    // a corresponding firm object and additional data is needed for conversion.
    // This data is called metadata and can contribute to the key that is used
    // for the internal builder cache (so that objects with different metadata
    // can be distinguished on lookup).
    //
    // Function types for example always have a pointer type for compound
    // structures, even if that structure is supposed to be passed by value. In
    // that case, the byval attributes (that belongs to the function definition
    // and calls, not to the function type) of the parameters are needed, to
    // distinguish the different resulting types in firm.
    //
    // The same applies to variadic functions. A different version is needed on
    // every function call, to reflect the variadic parameters of the current
    // call. In order to provide proper caching, the variadic parameters become
    // part of the types metadata.
    //
    // For this to work, the metadata objects (which can be polymorphic) have to
    // provide a hash function and an equality operator. Caching the hash value
    // is recommended for complex types (the key should never change anyhow).
    // Concerning overhead: for types without metadata, it's an additional null
    // pointer, belonging to the key, as well as checking that pointer on
    // lookup. If metadata is present, the additional overhead depends on the
    // metadatas hash and comparison methods.
    //
    // Also, the builder base classes don't expose metadata by default. It is up
    // to the implementing classes, to decide which interface to provide the
    // user, to specify metadata on building and lookup. Protected methods are
    // provided, to implement that interface.
    //
    // Builders that don't use metadata at all just use the empty metadata
    // struct below. A partial specialization of the UpFrontBuilder could be
    // also used in future, to get rid of the additional overhead involved.
    
    struct NoMetakey
    {
        bool operator==(const NoMetakey& other) const
        {
            return true;
        }
        
        std::size_t getHashValue() const
        {
            return 0;
        }
    };
    
    // The builder will create items on-demand, until finishConstruction() is
    // called. It will then switch to a lookup-only mode.
    template<typename SourceT, typename TargetT, typename MetakeyT = NoMetakey>
    class Builder
    {
    private:        
        // Compound key, that can store metadata along with the key, as long as
        // it provides a proper hash function and equality operator.
        struct CacheKey
        {
            CacheKey(SourceT source) : source(source), metakey() { }
            
            CacheKey(SourceT source, boost::shared_ptr<MetakeyT> metadata)
                : source(source), metakey(metadata) { }
            
            bool operator==(const CacheKey& other) const
            {
                if (source != other.source) return false;
                
                // Ensure that both sides either have metadata, or haven't.
                bool isNull      = (metakey.get() == 0);
                bool otherIsNull = (other.metakey.get() == 0);
                
                if (isNull != otherIsNull) return false;
                
                if (!isNull)
                {
                    // If metadata is specified, compare it.
                    if (!(*metakey == *other.metakey)) return false; 
                }
                
                return true;
            }
            
            friend std::size_t hash_value(const CacheKey& key)
            {
                std::size_t hash = 0;
                boost::hash_combine(hash, key.source);
                
                if (key.metakey.get() != 0)
                {
                    // Hash the metadata.
                    boost::hash_combine(hash, key.metakey->getHashValue());
                }
                
                return hash;
            }
            
            SourceT source;
            
            // A shared pointer gives the flexibility or polymorphic metadata
            // and saves space when no metadata is specified.
            boost::shared_ptr<MetakeyT> metakey;
        };
        
        typedef boost::unordered_map<CacheKey, TargetT> CacheMap;
        bool constructionIsDisabled;
        bool onDemandConstructionIsDisabled;
        CacheMap cache;
        
    protected:
        typedef typename CacheMap::const_iterator CacheMapCIt;
        
        CacheMapCIt cacheBegin()
        {
            return cache.cbegin();
        }
        
        CacheMapCIt cacheEnd()
        {
            return cache.cend();
        }
        
        // Try to find a value with the given key.
        TargetT lookup(SourceT source, boost::shared_ptr<MetakeyT> metakey)
        {
            CacheKey key(source, metakey);
            typename CacheMap::iterator targetIt = cache.find(key);
            if (targetIt == cache.end()) return 0;
            
            return (*targetIt).second;
        }
        
        // Try to insert a value with the given key. Asserts, that no old value
        // with that key existed.
        void cacheInsert(SourceT source, boost::shared_ptr<MetakeyT> metakey,
            TargetT target)
        {
            CacheKey key(source, metakey);
            std::pair<typename CacheMap::iterator, bool> result = cache.insert(
                typename CacheMap::value_type(key, target));
            assert(result.second && "A value with the given key already exists");
        }

        // Try to replace a value with the given key. Asserts, an old value with
        // that key existed.
        void cacheReplace(SourceT source, boost::shared_ptr<MetakeyT> metakey,
            TargetT target)
        {
            CacheKey key(source, metakey);
            
            typename CacheMap::iterator entryIt = cache.find(key);
            assert((entryIt != cache.end()) && "Entry doesn't exist");
            (*entryIt).second = target;
        }

        // Short form for the above method without metadata.
        TargetT lookup(SourceT source)
        {
            return lookup(source, boost::shared_ptr<MetakeyT>());
        }
        
        // Short form for the above method without metadata.
        void cacheInsert(SourceT source, TargetT target)
        {
            cacheInsert(source, boost::shared_ptr<MetakeyT>(), target);
        }
        
        // Short form for the above method without metadata.
        void cacheReplace(SourceT source, TargetT target)
        {
            cacheReplace(source, boost::shared_ptr<MetakeyT>(), target);
        }

        // Do the actual conversion. Implementors can return null, to indicate
        // that the given value can't be converted, but also, that this is no
        // error. Setting doCacheValue to false prevents caching of the result.
        virtual TargetT doBuild(SourceT source, bool& doCache) = 0;
        
    public:
        Builder() : constructionIsDisabled(false),
                    onDemandConstructionIsDisabled(false) { }
        
        // Try to get the given value from the cache. If that is not possible,
        // construct it and return the new object. valueWasCached returns
        // whether the value has been fetched from the cache.
        // If construction has been finished, this acts like a lookup method,
        // returning 0 if the value was not present.
        // Note that no metadata is used. If this is needed, inheriting classes
        // should provide their own interface for it.
        virtual TargetT retrieve(SourceT source, bool& wasCached)
        {
            // First try to look the value up.
            CacheKey key(source);
            typename CacheMap::iterator targetIt = cache.find(key);

            if (targetIt != cache.end())
            {
                // Get it from the cache.
                wasCached = true;
                return (*targetIt).second;
            }
            
            wasCached = false;
            
            if (!constructionIsDisabled && !onDemandConstructionIsDisabled)
            {
                // Startup the actual builder.
                bool doCacheValue = true;
                TargetT target = doBuild(source, doCacheValue);
                if (target == 0) return 0;
    
                if (doCacheValue)
                {
                    cacheInsert(source, target);
                }
                
                return target;
            }
            
            return 0;
        }
        
        // Short form for the above method.
        TargetT retrieve(SourceT source)
        {
            bool valueWasCached;
            return retrieve(source, valueWasCached);
        }
        
        // Builds a new value for the given value and asserts that it was not
        // already present, except if on-demand construction is still enabled.
        virtual TargetT build(SourceT source)
        {
            assert(!constructionIsDisabled && "Construction is disabled");
            
            // Building is allowed fetch values from the cache during on-demand
            // construction phase.
            if (!onDemandConstructionIsDisabled)
            {
                TargetT target = lookup(source);
                if (target != 0) return target; 
            }
            
            // Startup the actual builder.
            bool doCacheValue = true;
            TargetT target = doBuild(source, doCacheValue);
            if (target == 0) return 0;

            if (doCacheValue)
            {
                // This will do the insertion. If doCacheValue is false, the
                // doBuild() method should have inserted the value the same way.
                cacheInsert(source, target);
            }
            
            return target;
        }

        // Using disableConstruction asserts that no more construction appears
        // after the initial construction phase, but also allows for on-demand
        // construction afore.
        virtual void disableConstruction()
        {
            constructionIsDisabled = true;
        }
        
        // Sometimes it's required to disable on-demand construction during the
        // building phase. For example graphs should almost never be on-demand
        // constructed. Note that this can't be turned on again, to guarantee
        // that the constraint is always satisfied.
        // Also note that build() will not not complain, if a value is already
        // in the cache if on-demand construction is still enabled and just
        // return it.
        virtual void disableOnDemandConstruction()
        {
            onDemandConstructionIsDisabled = true;
        }
        
        virtual void clearCache()
        {
            cache.clear();
            constructionIsDisabled = false;
            onDemandConstructionIsDisabled = false;
        }
    };
}

#endif /* LTF_BLD_BUILDER_HPP_ */
