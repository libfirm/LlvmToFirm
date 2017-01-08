add_executable(ltf-llc
	Main.cpp
)

# Setup external dependencies.
include_directories(
	${ltf_SOURCE_DIR}
	${Boost_INCLUDE_DIRS}
	${LLVM_INCLUDE_DIRS}
	${Firm_INCLUDE_DIRS}
)

target_link_libraries(ltf-llc
	ltf
	${Boost_PROGRAM_OPTIONS_LIBRARY}
	${LLVM_ipo_LIBRARY}
	${LLVM_BitWriter_LIBRARY}
	${LLVM_TransformUtils_LIBRARY}
	${LLVM_BitReader_LIBRARY}
	${LLVM_AsmParser_LIBRARY}
	${LLVM_Analysis_LIBRARY}
	${LLVM_CodeGen_LIBRARY}
	${LLVM_Target_LIBRARY}
	${LLVM_CORE_LIBRARIES}
	${Firm_LIBRARIES}
	${PLATFORM_LIBRARIES}
)

# Setup installation process.
install(TARGETS ltf-llc RUNTIME DESTINATION bin)
