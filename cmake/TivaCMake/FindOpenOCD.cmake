# Distributed under the LICENSE found in tiva_cmake/LICENSE
#[========================================================================[.rst:
FindOpenOCD
----------------------

Finds `openocd`

Search in the following order:
1. Locally installed versions `/home/$(whoami)/openocd`

2. Globally installed versions: in the usual system places (~/usr/bin~ etc).


Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``OpenOCD_FOUND``
  True if the system has ti-cgt-arm installed

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``OpenOCD_EXECUTABLE``
  The openocd executable

``OpenOCD_CONFIG``
  The configuration file used by openocd for a given dev board

#]========================================================================]
# A guide for writing find modules: https://cmake.org/cmake/help/v3.17/manual/cmake-developer.7.html

# Determine what openocd board configuration file we are looking for based
# on CMAKE_SYSTEM_PROCESSOR or (if set in the cache) the OpenOCD_BOARD variable
# This is the configuration filename to search for when we try to find openocd configurations
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "TM4C123GH6PM")
  set(OpenOCD_BOARD "ek-tm4c123gxl.cfg" CACHE STRING "The openocd configuration to use")
endif()

find_program(OpenOCD_EXECUTABLE openocd
  HINTS $ENV{HOME}/openocd
  PATH_SUFFIXES bin
  )

# find the open ocd configruation file
find_file(OpenOCD_CONFIG
  ${OpenOCD_BOARD}
  PATHS
  "$ENV{HOME}/openocd"
  "$ENV{HOME}/openocd/share"
  "$ENV{HOME}/openocd/usr/share"
  "/usr/local/share/openocd/"
  "/usr/share/openocd/"
  PATH_SUFFIXES "scripts/board"
  CMAKE_FIND_ROOT_PATH_BOTH)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenOCD
    FOUND_VAR OpenOCD_FOUND
    REQUIRED_VARS
    OpenOCD_EXECUTABLE
    OpenOCD_CONFIG
    #VERSION_VAR OpenOCD_VERSION - TODO
    )
