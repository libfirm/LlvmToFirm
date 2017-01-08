#ifndef LTF_FACADE_OPTIMIZER_HPP_
#define LTF_FACADE_OPTIMIZER_HPP_

#include <string>
#include <boost/shared_ptr.hpp>
#include <boost/unordered_map.hpp>
#include "../Optimizations/BasePasses.hpp"
#include "../RAII/FirmHandle.hpp"

namespace ltf
{
    // Basically, each optimization has a pass defined in OptimizerPasses.hpp,
    // that also provides accessor functions to set pass-specific settings. The
    // Optimizer class can be inherited, to implement an optimizer strategy.
    // From there, passes can be accessed by calling getPass<T>.
    // The optimizer can then provide convenience methods to set optimization
    // settings, passes to run etc. and can in turn set those settings on the
    // individial passes.
    // The optimize() method has to be overwritten and should call the run()
    // methods of the appropriate passes, employing some (potentially hard-
    // coded) optimization strategy. It is also responsible for lowering the
    // firm graph for the backend.
    // The prepareConstruction() method is called prior to the construction of
    // firm graphs and can set optimization settings for construction.
    // Similarly, prepareBackend() is called prior to running the backend and
    // can set settings of the backend.
    class Optimizer
    {        
    protected:
        typedef boost::shared_ptr<opt::Pass> PassSPtr;
        typedef boost::unordered_map<std::string, PassSPtr> PassMap;
        
        bool    defaultIsEnabled;
        PassMap passes;
        
    public:
        Optimizer() : defaultIsEnabled(false) { }
        
        virtual void setOptLevel(int level) = 0;
        virtual void prepareConvert()       = 0;
        virtual void prepareBackend()       = 0;
        virtual void run()                  = 0;
        
    protected:
        // Retrieve the pass with the given type. If needed, instanciate it.
        // This way, one can lazily access the passes by type, without casting
        // and local settings can be stored along with each pass, while no
        // registration is necessary.
        template<typename PassT>
        boost::shared_ptr<PassT> getPass()
        {
            // Get the passes name, which is used as key.
            std::string name = PassT::getName();
            
            PassMap::iterator it = passes.find(name);
            PassSPtr pass;
            
            if (it == passes.end())
            {
                // Instantiate the pass and add it to the map.
                pass = PassSPtr(new PassT());
                pass->setIsEnabled(defaultIsEnabled);
                passes.insert(PassMap::value_type(name, pass));
            }
            else
            {
                pass = it->second;
            }
            
            return boost::static_pointer_cast<PassT>(pass);
        }
        
        // Enable/disable all passes (including non-instanciated ones).
        void setAllIsEnabled(bool isEnabled)
        {
            for (PassMap::iterator it = passes.begin(),
                eit = passes.end(); it != eit; ++it)
            {
                it->second->setIsEnabled(isEnabled);
            }
            
            defaultIsEnabled = isEnabled;
        }
        
        void repairFrameTypes();
        void finalizeFrameTypes();
    };
}

#endif /* LTF_FACADE_OPTIMIZER_HPP_ */
