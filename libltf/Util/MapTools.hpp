#ifndef LTF_UTIL_MAP_TOOLS_HPP_
#define LTF_UTIL_MAP_TOOLS_HPP_

#include <boost/foreach.hpp>
#include <boost/unordered_set.hpp>
#include <boost/unordered_map.hpp>

namespace ltf
{
    namespace map
    {
        // Adds the maps keys to the given set.
        template<typename KeyT, typename ValueT>
        void addKeysToSet(const boost::unordered_map<KeyT, ValueT>& map,
            boost::unordered_set<KeyT>& set)
        {
            typedef typename boost::unordered_map
                <KeyT, ValueT>::value_type EntryType;

            BOOST_FOREACH (const EntryType& entry, map)
            {
                set.insert(entry.first);
            }
        }
    }
}

#endif /* LTF_UTIL_MAP_TOOLS_HPP_ */
