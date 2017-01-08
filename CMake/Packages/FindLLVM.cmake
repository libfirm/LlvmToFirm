include(FindMacros)

begin_find(LLVM)

# Add the core components.
set(_LLVM_CORE_COMPONENTS Core Support System)
foreach (COMPONENT ${_LLVM_COMPONENTS})
	list(REMOVE_ITEM LLVM_FIND_COMPONENTS ${COMPONENT})
endforeach (COMPONENT ${_LLVM_COMPONENTS})
set(_LLVM_COMPONENTS ${LLVM_FIND_COMPONENTS} ${_LLVM_CORE_COMPONENTS})

# Set the fallback search paths.
if (WIN32)
	set(_LLVM_INCLUDE_HINTS C:/LLVM/include "$ENV{ProgramFiles}/LLVM/include")
	set(_LLVM_LIBRARY_HINTS C:/LLVM/lib "$ENV{ProgramFiles}/LLVM/lib")
else (WIN32)
	set(_LLVM_INCLUDE_HINTS /include /usr/include /usr/local/include)
	set(_LLVM_LIBRARY_HINTS /lib /usr/lib /usr/local/lib /lib/llvm /lib/llvm/lib
		/usr/lib/llvm /usr/lib/llvm/lib /usr/local/lib/llvm /usr/local/lib/llvm/lib
		$ENV{LD_LIBRARY_PATH})
endif (WIN32)

# Try to gather the environment variable for the root directory.
try_env_path(_LLVM_ROOT LLVM_ROOT)
try_env_path(_LLVM_ROOT LLVMROOT)
try_env_path(_LLVM_ROOT LLVM_HOME)
try_env_path(_LLVM_ROOT LLVMHOME)

if (_LLVM_ROOT)
	set(_LLVM_INCLUDE_HINTS ${_LLVM_ROOT}/include ${_LLVM_INCLUDE_HINTS})
	set(_LLVM_LIBRARY_HINTS ${_LLVM_ROOT}/lib ${_LLVM_LIBRARY_HINTS})
endif (_LLVM_ROOT)

# Try to use llvm-config.
find_program(_LLVM_CONFIG llvm-config $ENV{PATH} /bin /usr/bin)

if (_LLVM_CONFIG)
	exec_program(${_LLVM_CONFIG} ARGS --includedir OUTPUT_VARIABLE _LLVM_CONFIG_INCLUDE)
	exec_program(${_LLVM_CONFIG} ARGS --libdir OUTPUT_VARIABLE _LLVM_CONFIG_LIBRARY)
	set(_LLVM_INCLUDE_HINTS ${_LLVM_CONFIG_INCLUDE} ${_LLVM_INCLUDE_HINTS})
	set(_LLVM_LIBRARY_HINTS ${_LLVM_CONFIG_LIBRARY} ${_LLVM_LIBRARY_HINTS})
endif (_LLVM_CONFIG)

# Search for the header files.
try_find_header(llvm/Module.h LLVM_INCLUDE_DIR _LLVM_INCLUDE_HINTS)
set(LLVM_INCLUDE_DIRS ${LLVM_INCLUDE_DIR})

# Search for each of the components.
foreach (COMPONENT ${_LLVM_COMPONENTS})

	try_find_lib(LLVM${COMPONENT} LLVM_${COMPONENT}_LIBRARY _LLVM_LIBRARY_HINTS)
	set(LLVM_LIBRARIES ${LLVM_LIBRARIES} ${LLVM_${COMPONENT}_LIBRARY})
	
	# If it is a core component, add it to LLVM_CORE_LIBRARIES.
	list(FIND _LLVM_CORE_COMPONENTS ${COMPONENT} _LLVM_IS_CORE_COMPONENT)
	if (NOT _LLVM_IS_CORE_COMPONENT EQUAL -1)
		set(LLVM_CORE_LIBRARIES ${LLVM_CORE_LIBRARIES} ${LLVM_${COMPONENT}_LIBRARY})
	endif (NOT _LLVM_IS_CORE_COMPONENT EQUAL -1)
	
endforeach (COMPONENT ${_LLVM_COMPONENTS})

end_find()
