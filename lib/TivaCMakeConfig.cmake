# This file is run when find_package(TivaCMake) is called
# This variable determines if we link against release or debug verions of the library
set(STARTUPLIB_DEBUG OFF CACHE BOOL "If ON, link against the debugging version of driverlib")

if(STARTUPLIB_DEBUG)
  include("${CMAKE_CURRENT_LIST_DIR}/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}/TivaCMakeTargets_Debug.cmake")
else()
  include("${CMAKE_CURRENT_LIST_DIR}/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}/TivaCMakeTargets_Release.cmake")
endif()
