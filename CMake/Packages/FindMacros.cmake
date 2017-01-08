macro(begin_find NAME)
	set(_FM_NAME ${NAME})
	
	if (NOT ${_FM_NAME}_FIND_QUIETLY)
		message(STATUS "Searching ${_FM_NAME}...")
	endif (NOT ${_FM_NAME}_FIND_QUIETLY)

	# Set to true, if a file is missing.
	set (_${_FM_NAME}_MISSING FALSE)
endmacro(begin_find)

macro(end_find)
	# Not yet found and no file missing? Mark it found.
	if (NOT ${_FM_NAME}_FOUND AND NOT _${_FM_NAME}_MISSING)
		set(${_FM_NAME}_FOUND TRUE)
	endif (NOT ${_FM_NAME}_FOUND AND NOT _${_FM_NAME}_MISSING)

	if (${_FM_NAME}_FOUND AND NOT ${_FM_NAME}_FIND_QUIETLY)
		message(STATUS "${_FM_NAME} found.")
	endif (${_FM_NAME}_FOUND AND NOT ${_FM_NAME}_FIND_QUIETLY)

	# Unfound, but required. Raise an error.
	if (${_FM_NAME}_FIND_REQUIRED AND NOT ${_FM_NAME}_FOUND)
		message(SEND_ERROR "${_FM_NAME} required, but not found.")
	endif (${_FM_NAME}_FIND_REQUIRED AND NOT ${_FM_NAME}_FOUND)
endmacro(end_find)

macro(try_env_path VAR ENVVAR)
	# If var is not defined, but envvar is, copy the value.
	if (NOT ${VAR} AND NOT $ENV{${ENVVAR}} STREQUAL "")
	
		if (_${_FM_NAME}_DEBUG)
			message(STATUS "Using environment variable ${ENVVAR}.")
		endif (_${_FM_NAME}_DEBUG)
		
		set(${VAR} $ENV{${ENVVAR}})
		# And convert the path to cmake.
		file(TO_CMAKE_PATH ${${VAR}} ${VAR})
		
	endif (NOT ${VAR} AND NOT $ENV{${ENVVAR}} STREQUAL "")
endmacro(try_env_path)

macro(try_find_header FILE VAR HINTS)
	if (_${_FM_NAME}_DEBUG)
		message(STATUS "Searching for header ${FILE} in ${${HINTS}}")
	endif (_${_FM_NAME}_DEBUG)
	
	find_path(${VAR} NAMES ${FILE} HINTS ${${HINTS}})
	if (_${_FM_NAME}_DEBUG AND ${VAR})
		message(STATUS "Found header ${${VAR}}")
	endif (_${_FM_NAME}_DEBUG AND ${VAR})
	
	if (NOT ${VAR}) # Set missing to true.
		message(STATUS "Couldn't find header ${FILE}")
		set (_${_FM_NAME}_MISSING TRUE)
	endif (NOT ${VAR})
endmacro(try_find_header)

macro(try_find_lib FILE VAR HINTS)
	if (_${_FM_NAME}_DEBUG)
		message(STATUS "Searching for library ${FILE} in ${${HINTS}}")
	endif (_${_FM_NAME}_DEBUG)
	
	find_library(${VAR} NAMES ${FILE} lib${FILE} HINTS ${${HINTS}})
	if (_${_FM_NAME}_DEBUG AND ${VAR})
		message(STATUS "Found library ${${VAR}}")
	endif (_${_FM_NAME}_DEBUG AND ${VAR})
	
	if (NOT ${VAR}) # Set missing to true.
		message(STATUS "Couldn't find library ${FILE}")
		set (_${_FM_NAME}_MISSING TRUE)
	endif (NOT ${VAR})
endmacro(try_find_lib)

macro(select_library TARGET TARGETS DBGLIB RELLIB)
	if (${DBGLIB} AND ${RELLIB})
		# Set the target library, if cmake supports different ones.
      if (CMAKE_CONFIGURATION_TYPES OR CMAKE_BUILD_TYPE)
        set (${TARGET} optimized ${${RELLIB}} debug ${${DBGLIB}})
      else (CMAKE_CONFIGURATION_TYPES OR CMAKE_BUILD_TYPE)
        set (${TARGET} ${${RELLIB}})
      endif (CMAKE_CONFIGURATION_TYPES OR CMAKE_BUILD_TYPE)

		set (${TARGETS} optimized ${${RELLIB}} debug ${${DBGLIB}})
    endif (${DBGLIB} AND ${RELLIB})
	 
	 if (${RELLIB} AND NOT ${DBGLIB})
		set (${DBGLIB} ${${RELLIB}})
		set (${TARGET} ${${RELLIB}})
		set (${TARGETS} ${${RELLIB}})
	 endif (${RELLIB} AND NOT ${DBGLIB})
	 
	 if (${DBGLIB} AND NOT ${RELLIB})
		set (${RELLIB} ${${DBGLIB}})
		set (${TARGET} ${${DBGLIB}})
		set (${TARGETS} ${${DBGLIB}})
	 endif (${DBGLIB} AND NOT ${RELLIB})
endmacro(select_library)
