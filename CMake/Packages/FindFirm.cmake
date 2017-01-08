include(FindMacros)

begin_find(Firm)

# Set the fallback search paths.
if (WIN32)
	set(_Firm_INCLUDE_HINTS C:/Firm/include "$ENV{ProgramFiles}/Firm/include")
	set(_Firm_LIBRARY_HINTS C:/Firm/lib "$ENV{ProgramFiles}/Firm/lib")
else (WIN32)
	set(_Firm_INCLUDE_HINTS /include /usr/include /usr/local/include)
	set(_Firm_LIBRARY_HINTS /lib /usr/lib /usr/local/lib /lib/Firm /lib/Firm/lib
		/usr/lib/Firm /usr/lib/Firm/lib /usr/local/lib/Firm /usr/local/lib/Firm/lib)
endif (WIN32)

# Try to gather the environment variable for the root directory.
try_env_path(_Firm_ROOT Firm_ROOT)
try_env_path(_Firm_ROOT FirmROOT)
try_env_path(_Firm_ROOT Firm_HOME)
try_env_path(_Firm_ROOT FirmHOME)
try_env_path(_Firm_ROOT FIRM_ROOT)
try_env_path(_Firm_ROOT FIRMROOT)
try_env_path(_Firm_ROOT FIRM_HOME)
try_env_path(_Firm_ROOT FIRMHOME)

if (_Firm_ROOT)
	set(_Firm_INCLUDE_HINTS ${_Firm_ROOT}/include ${_Firm_INCLUDE_HINTS})
	set(_Firm_LIBRARY_HINTS ${_Firm_ROOT}/lib ${_Firm_LIBRARY_HINTS})
endif (_Firm_ROOT)

# Search for the header files.
try_find_header(libfirm/firm.h Firm_INCLUDE_DIR _Firm_INCLUDE_HINTS)
set(Firm_INCLUDE_DIRS ${Firm_INCLUDE_DIR})

# Search for the libraries.
try_find_lib(firm Firm_LIBRARY _Firm_LIBRARY_HINTS)
try_find_lib(lpp Lpp_LIBRARY _Firm_LIBRARY_HINTS)
try_find_lib(core Core_LIBRARY _Firm_LIBRARY_HINTS)
set(Firm_LIBRARIES ${Firm_LIBRARY} ${Lpp_LIBRARY} ${Core_LIBRARY})

end_find()
