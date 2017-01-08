#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <boost/foreach.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/program_options.hpp>
#include <libltf/Library.hpp>
using ltf::log::LogLevel;
namespace po = boost::program_options;

namespace
{
    // Simple argument form with one dash (-arch instead of --arch).
    std::pair<std::string, std::string> parseSimple(const std::string& str)
    {
        if ((str.size() <= 2  ) || // "-x"
            (str[0]     != '-') || // "xy..."
            (str[1]     == '-'))   // "--..."
        {
            // Not in --xy form.
            return std::make_pair(std::string(), std::string());
        }
        
        std::pair<std::string, std::string> result;
        std::size_t index = str.find('=');
        
        if (index == std::string::npos)
        {
            // Just -xy, no assignment.
            result = std::make_pair(str.substr(1), std::string());
        }
        else
        {
            // Assignment -xy=value.
            result = std::make_pair(str.substr(1, index - 1), str.substr(index + 1));
        }
    
        return result;
    }
    
    // -Ox option parsing.
    std::pair<std::string, std::string> parseOptLevel(const std::string& str)
    {
        if (str.find("-O") == 0)
        {
            return std::make_pair("opt", str.substr(2));
        }
        
        return std::make_pair(std::string(), std::string());
    }
    
    void printUsage()
    {
        std::cerr << "Usage: ltf-llc [options] [input] [output]" << std::endl;
    }
    
    int parseCommandLine(po::variables_map& variables, int argc, char* argv[])
    {
        /* ================================================================== */
        /* =                         Argument setup                         = */
        /* ================================================================== */
        
        // Define command line arguments.
        po::options_description general("General options");
        general.add_options()
            ("help,h",                             "show help message")
            ("input,i",  po::value<std::string>(), "input filename")
            ("output,o", po::value<std::string>(), "output filename")
            ("asm,S",                              "parse as LLVM assembler")
            ("firm",                               "parse as firm IR program")
            ("firm-low",                           "parse as lowered firm IR program")
            ("emit-firm",                          "emit firm IR program")
            ("emit-firm-low",                      "emit lowered firm IR program")
            ("opt,O",    po::value<std::string>(), "set optimization level")
            ("be-arg",   po::value< std::vector<std::string> >(),
                                                   "pass argument to backend")
            ("strict-math",                        "use the strict math model")
            ("fast-math",                          "use the fast math model")
            ("no-call-conv-opt",                   "disable call conv optimization")
        ;
        
        int defaultLogLevel = static_cast<int>(LogLevel::Warning);
        int lowestLogLevel  = static_cast<int>(LogLevel::Lowest);
        int highestLogLevel = static_cast<int>(LogLevel::Highest);
        
        std::ostringstream logLevelStream;
        logLevelStream << "log level (" << lowestLogLevel << " to " <<
            highestLogLevel << ")";
        
        po::options_description debug("Debugging options");
        debug.add_options()
            ("log-level",    po::value<int>()->default_value(defaultLogLevel),
                             logLevelStream.str().c_str())
            ("dump-all",     "dump all graphs")
            ("dump-types",   "dump the type graph")
            ("dump-irg",     "dump all function graphs")
            ("dump-irg-low", "dump all lowered function graphs")
        ;
        
        po::options_description backend("Backend options");
        backend.add_options()
            ("arch", po::value<std::string>()->default_value("i686"),
                     "target architecture") // XXX: i686 needed for mux
        ;
        
        po::options_description all("Options");
        all.add(general).add(debug).add(backend);
    
        po::positional_options_description positionalDescription;
        positionalDescription.add("input",  1);
        positionalDescription.add("output", 2);
    
        /* ================================================================== */
        /* =                      Command-line parsing                      = */
        /* ================================================================== */
        
        try
        {
            // Parse the command line.
            po::store(po::command_line_parser(argc, argv)
                      .options      (all)
                      .positional   (positionalDescription)
                      .extra_parser (parseSimple)
                      .extra_parser (parseOptLevel)
                      .run          (),
                      variables);
            
            po::notify(variables);
        }
        catch (std::exception& e)
        {
            std::cerr << e.what() << std::endl;
            return EXIT_FAILURE;
        }

        // Show the help.
        if (variables.count("help"))
        {
            printUsage();
            std::cerr << std::endl;
            std::cerr << all << std::endl;
            return EXIT_FAILURE;
        }
        
        // Ensure that input and output are specified.
        if (!variables.count("input") || !variables.count("output"))
        {
            printUsage();
            return EXIT_FAILURE;
        }
    
        return EXIT_SUCCESS;
    }
}

int main(int argc, char* argv[])
{    
    // Parse the command line.
    po::variables_map variables;
    int result = parseCommandLine(variables, argc, argv);
    if (result != EXIT_SUCCESS) return result;

	try
	{
        std::string inputFile  = variables["input" ].as<std::string>();
        std::string outputFile = variables["output"].as<std::string>();
        std::string arch       = variables["arch"  ].as<std::string>();
     
        // Determine the optimization level to use. Default to -O1.
        int optLevel = 1;
        
        if (variables.count("opt"))
        {
            std::string optLevelStr = variables["opt"].as<std::string>();
            
            if (optLevelStr == "s")
            {
                // Size optimization is usually stored as -1. It is not really
                // supported though, so it defaults to -O1 here.
                optLevel = 1;
            }
            else
            {
                try
                {
                    // Try to lexical cast the specified number.
                    optLevel = boost::lexical_cast<int>(optLevelStr);
                    
                    if ((optLevel < 0) || (optLevel > 3))
                    {
                        throw boost::bad_lexical_cast();
                    }
                }
                catch (boost::bad_lexical_cast&)
                {
                    std::cerr << "Invalid optimization level" << std::endl;
                    return EXIT_FAILURE;
                }
            }
        }
        
        // Set the requested log level.
        int logLevel = variables["log-level"].as<int>();
        if (logLevel > LogLevel::Highest) logLevel = LogLevel::Highest;
        if (logLevel < LogLevel::Lowest)  logLevel = LogLevel::Lowest;
        ltf::log::setLogLevel(static_cast<LogLevel::Enum>(logLevel));

        // Setup the convert.
        ltf::FirmHandle firmHandle(0);
        ltf::Converter  converter(firmHandle);
        
        converter.setInputFile    (inputFile);
        converter.setOutputFile   (outputFile);
        converter.setArchitecture (arch);
        converter.setOptLevel     (optLevel);
        
        // The main use at the time is to compile GCC on -O03.
        // [TODO] implement proper pass selection 
        if (variables.count("no-call-conv-opt"))
        {
            boost::shared_static_cast<ltf::CParserOptimizer>(
                converter.getOptimizer()
            )->setCallConvOptIsEnabled(false);
        }
        
        // Setup the math model.
        if (variables.count("strict-math") &&
            variables.count("fast-math"))
        {
            std::cerr << "Please specify only one math model" << std::endl;
            return EXIT_FAILURE;
        }
        
        if (variables.count("strict-math"))
        {
            converter.setFPModel(ltf::FPModel::Strict);
        }
        else if (variables.count("fast-math"))
        {
            converter.setFPModel(ltf::FPModel::Fast);
        }
        else
        {
            converter.setFPModel(ltf::FPModel::Precise);
        }

        // Apply backend options. Needs to be done here.
        be_opt_register();
        
        if (variables.count("be-arg"))
        {
            std::vector<std::string> backendOpts =
                variables["be-arg"].as< std::vector<std::string> >();
    
            BOOST_FOREACH (std::string& opt, backendOpts)
            {
                if (be_parse_arg(opt.c_str()) < 0)
                {
                    return EXIT_FAILURE;
                }
            }
        }
        
        /* ================================================================== */
        /* =                         Transformation                         = */
        /* ================================================================== */
        
        // Convert the module, or just import the IR program.
        if (variables.count("firm") || variables.count("firm-low"))
        {
            bool isLowered = variables.count("firm-low");
            converter.importFirm(inputFile.c_str(), isLowered);
        }
        else
        {
            if (variables.count("asm"))
            {
                // Change the input parser for assembler files.
                converter.setParser(
                    ltf::ParserSPtr(new ltf::LlvmAssemblerParser())
                );
            }
    
            // Prepare and convert the LLVM module.
            converter.runConvert();
        }
        
        /* ================================================================== */
        /* =                    Lowering / Optimization                     = */
        /* ================================================================== */

        if (converter.getCurrentStage() < ltf::ProgramStage::Optimized)
        {
            // High-level dumps.
            if (variables.count("dump-types") || variables.count("dump-all"))
            {
                dump_all_types("");
            }
            
            if (variables.count("dump-irg") || variables.count("dump-all"))
            {
                dump_all_ir_graphs(dump_ir_block_graph, "");
            }
            
            if (variables.count("emit-firm"))
            {
                // Directly export.
                converter.exportFirm(outputFile.c_str(), false);
                return EXIT_SUCCESS;
            }
            
            // Run the optimization stuff.
            converter.runOptimize();
        }
        
        /* ================================================================== */
        /* =                            Backend                             = */
        /* ================================================================== */
        
        // Low-level dumps.
        if (variables.count("dump-irg-low") || variables.count("dump-all"))
        {
            dump_all_ir_graphs(dump_ir_block_graph, "-low");
        }
        
        if (variables.count("emit-firm-low"))
        {
            // Export the lowered graphs.
            converter.exportFirm(outputFile.c_str(), true);
            return EXIT_SUCCESS;
        }
        
        // Run the firm backend.
        converter.runBackend();
    }
    catch (std::exception& e)
    {
    	std::cerr << "Internal compiler error." << std::endl;
    	std::cerr << e.what() << std::endl;
        return EXIT_FAILURE;
    }
    
    return EXIT_SUCCESS;
}
