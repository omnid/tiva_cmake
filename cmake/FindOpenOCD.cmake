# Distributed under the LICENSE found in tiva-cmake/LICENSE
#[========================================================================[.rst:
FindOpenOCD
----------------------

Finds `openocd`

Search in the following order:
1. Locally installed versions `/home/$(whoami)/openocd`

2. Globally installed versions: `/opt/arm-none-eabi-gcc*`, `/opt/gcc-arm-none-eabi*` and the system path


Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``ArmNoneEabiGCC_FOUND``
  True if the system has ti-cgt-arm installed
``ArmNoneEabiGCC_VERSION``
  The version of ti-cgt-arm that was found.
``ArmNoneEabiGCC_ROOT_DIR``
  The root directory of the arm-none-eabi-gcc compiler

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``OpenOCD_Executable``
  The openocd executable

``OpenOCD_DATADIR``
  The 

#]========================================================================]
# A guide for writing find modules: https://cmake.org/cmake/help/v3.17/manual/cmake-developer.7.html

find_program(OPENOCD openocd)

if(${OPENOCD} STREQUAL "OPENOCD-NOTFOUND")
  message(WARNING
    "${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE} - Could not find openocd,
     make target.gdb, make target.attach, and make target.write will not work.")
endif()

# find the open ocd configruation file
find_file(OPENOCD_CONFIG
  "ek-tm4c123gxl.cfg" PATHS "/usr/share/openocd/scripts/board" CMAKE_FIND_ROOT_PATH_BOTH)
if(${OPENOCD_CONFIG} STREQUAL "OPENOCD_CONFIG-NOTFOUND")
  message(FATAL_ERROR
    "${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE} - could not find openocd configration file")
endif()

