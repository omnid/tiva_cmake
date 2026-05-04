# This file is run when find_package(TivaCMake) is called
# This variable determines if we link against release or debug verions of the library and finds the proper library
set(TIVASTARTUP_BUILD_TYPE "Release" CACHE STRING "The CMAKE_BUILD_TYPE for the startup library that is linked against")
set_property(CACHE TIVASTARTUP_BUILD_TYPE PROPERTY STRINGS Debug Release)

# CMAKE_CURRENT_LIST_DIR expands to where this file is located in the installation

if(TIVASTARTUP_BUILD_TYPE STREQUAL "Debug")
  include("${CMAKE_CURRENT_LIST_DIR}/../TivaStartup-${CMAKE_C_COMPILER_ID}-Debug/share/TivaStartup/TivaStartupTargets.cmake")
elseif(TIVASTARTUP_BUILD_TYPE STREQUAL "Release")
  include("${CMAKE_CURRENT_LIST_DIR}/../TivaStartup-${CMAKE_C_COMPILER_ID}-Release/share/TivaStartup/TivaStartupTargets.cmake")
else()
  message(FATAL_ERROR "Invalid value: TIVASTARTUP_BUILD_TYPE=${TIVA_STARTUP_BUILD_TYPE}, expected Debug or Release")
endif()
