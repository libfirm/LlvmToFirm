#include <iostream>
#include <cstdlib>
#include <FirmLlvmFrontend/Frontend.hpp>
#include "FileHandle.hpp"

int main(int argc, char* argv[])
{
	try
    {
        if (argc != 3)
        {
            std::cerr << "Usage: FirmLlvmCompiler [input] [output]" << std::endl;
            return EXIT_FAILURE;
        }
        
        ltf::FirmHandle firmHandle(0);
        
        // Pass the file to the frontend.
        ltf::Frontend frontend;
        frontend.transformAssembler(firmHandle, std::string(argv[1]));
        
        ltf::LogTime logTime("Dumping");
        
        // XXX: remove dumps.
        dump_all_types("");
        dump_all_ir_graphs(dump_ir_block_graph, "");
        
        logTime.next("Lowering");
        
        // Lower Sel and SymConst nodes.
        lower_highlevel(false);
        
        // Lower 64 Bit modes.
        const backend_params* backendParams = be_get_backend_param();
        
        // XXX: this doesn't always work.
        lwrdw_param_t lowerDwordParams;
        lowerDwordParams.enable           = true;
        lowerDwordParams.high_signed      = mode_Ls;
        lowerDwordParams.high_unsigned    = mode_Lu;
        lowerDwordParams.low_signed       = mode_Is;
        lowerDwordParams.low_unsigned     = mode_Iu;
        lowerDwordParams.little_endian    = true;
        lowerDwordParams.create_intrinsic = backendParams->arch_create_intrinsic_fkt;
        lowerDwordParams.ctx              = backendParams->create_intrinsic_ctx;
        lower_dw_ops(&lowerDwordParams);
        
        logTime.next("Dumping");
        
        // XXX: remove dumps.
        dump_all_ir_graphs(dump_ir_block_graph, "-lowered");
        
        logTime.next("Backend");
        
        // Run everything through the backend.
        FileHandle fileHandle(argv[2], "w");
        
        be_parse_arg("dump=all");
        be_parse_arg("ia32-gasmode=elf");
        be_main(fileHandle.get(), "<builtin>");
    }
    catch (std::exception& e)
    {
    	std::cerr << "Internal compiler error." << std::endl;
    	std::cerr << e.what() << std::endl;
        return EXIT_FAILURE;
    }
    
    return EXIT_SUCCESS;
}
