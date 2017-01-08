cmake_minimum_required(VERSION 2.6)
project(ltf)

# Include additional modules.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/CMake/Packages")

# avoid boosts automatic linking for msvc and borland compilers and
# lets cmake do this. That ensures, that the libraries found by boost
# are used and no further configuration in visual studio is needed.
add_definitions("-DBOOST_ALL_NO_LIB")
set(Boost_ADDITIONAL_VERSIONS "1.39" "1.40")
find_package(Boost REQUIRED program_options)

# Find the external libraries.
find_package(LLVM REQUIRED COMPONENTS BitReader AsmParser Analysis CodeGen
                                      Target TransformUtils BitWriter ipo)
find_package(Firm REQUIRED)

# Firm needs this.
find_package(ZLIB REQUIRED)

if (NOT WIN32)
	set(PLATFORM_LIBRARIES pthread z dl)
endif (NOT WIN32)

# These are needed for llvm.
add_definitions("-D__STDC_LIMIT_MACROS")
add_definitions("-D__STDC_CONSTANT_MACROS")

if (CMAKE_BUILD_TYPE STREQUAL Debug)
    add_definitions("-D_DEBUG")
endif (CMAKE_BUILD_TYPE STREQUAL Debug)

# Turn on warnings.
set(CMAKE_CXX_FLAGS "-Wall -Wno-switch")

# Process the subdirectories.
add_subdirectory(libltf)
add_subdirectory(ltf-llc)
