add_executable(FirmLlvmCompiler
	Compiler.cpp
	FileHandle.cpp
	FileHandle.hpp
)

# Setup external dependencies.
include_directories(
	${LlvmToFirm_SOURCE_DIR}
	${Boost_INCLUDE_DIRS}
	${LLVM_INCLUDE_DIRS}
	${Firm_INCLUDE_DIRS}
)

target_link_libraries(FirmLlvmCompiler
	FirmLlvmFrontend
	${LLVM_BitReader_LIBRARY}
	${LLVM_AsmParser_LIBRARY}
	${LLVM_Analysis_LIBRARY}
	${LLVM_CORE_LIBRARIES}
	${Firm_LIBRARIES}
	${PLATFORM_LIBRARIES}
)

# Setup installation process.
install(TARGETS FirmLlvmCompiler RUNTIME DESTINATION bin)
