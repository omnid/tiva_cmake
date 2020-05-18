# Distributed under the LICENSE found in tiva-cmake/LICENSE
#[========================================================================[.rst:
FindTiCgtArm
----------------------

Finds the TI cgt compiler for arm microprocessors.
It will first search in `/home/$(whoami)/ti/ti-cgt-arm*` `/home/$(whoami)/ti-cgt-arm*` `/opt/ti/ti-cgt-arm*` `/opt/ti-cgt-arm*`.
Then it will search within Code Composer Studio.
Finally it will look on your system path.

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``TiCgtArm_FOUND``
  True if the system has ti-cgt-arm installed
``TiCgtArm_VERSION``
  The version of ti-cgt-arm that was found.

``TiCgtArm_C_LIBRARY_DIRS``
  Location of the C standard library

``TiCgtArm_C_INCLUDE_DIRS``
  Include directories for the C standard library

``TiCgtArm_C_SOURCE_DIRS``
  Directory with source code for the C standard library

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``TiCgtArm_EXECUTABLE``
  The compiler executable

#]========================================================================]
# A guide for writing find modules: https://cmake.org/cmake/help/v3.17/manual/cmake-developer.7.html
find_package(CodeComposerStudio)

# Glob each search directory since the name contains the version of the compiler
# Reverse the results so that the directory with the highest versions are first
file(GLOB TiCgtArm_HINTS1 $ENV{HOME}/ti/ti-cgt-arm*)
list(REVERSE TiCgtArm_HINTS1)

file(GLOB TiCgtArm_HINTS2 $ENV{HOME}/ti-cgt-arm*)
list(REVERSE TiCgtArm_HINTS2)

file(GLOB TiCgtArm_HINTS3 /opt/ti/ti-cgt-arm*)
list(REVERSE TiCgtArm_HINTS3)

file(GLOB TiCgtArm_HINTS3 /opt/ti/ti-cgt-arm*)
list(REVERSE TiCgtArm_HINTS3)

file(GLOB TiCgtArm_HINTS4 /opt/ti-cgt-arm*)
list(REVERSE TiCgtArm_HINTS4)

file(GLOB TiCgtArm_HINTS5 ${CodeComposerStudio_ROOT_DIR}/ccs*/tools/compiler/ti-cgt-arm*)
list(REVERSE TiCgtArm_HINTS5)
          
find_program(TiCgtArm_EXECUTABLE
        NAMES armcl
        HINTS ${TiCgtArm_HINTS1} ${TiCgtArm_HINTS2} ${TiCgtArm_HINTS3} ${TiCgtArm_HINTS4} ${TiCgtArm_HINTS5}
        PATH_SUFFIXES bin
        )

# compute paths to the C standard library
get_filename_component(TiCgtArm_BIN_DIR ${TiCgtArm_EXECUTABLE} DIRECTORY)
get_filename_component(TiCgtArm_ROOT_DIR ${TiCgtArm_BIN_DIR}/.. ABSOLUTE)

set(TiCgtArm_C_INCLUDE_DIRS ${TiCgtArm_ROOT_DIR}/include)
set(TiCgtArm_C_LIBRARY_DIRS ${TiCgtArm_ROOT_DIR}/lib ABSOLUTE)
set(TiCgtArm_C_SOURCE_DIRS ${TiCgtArm_C_LIBRARY_DIRS}/src)

# compute the version
get_filename_component(TiCgtArm_VERSION_DIR ${TiCgtArm_ROOT_DIR} NAME)
string(REGEX REPLACE "ti-cgt-arm." "" TiCgtArm_VERSION ${TiCgtArm_VERSION_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TiCgtArm
        FOUND_VAR TiCgtArm_FOUND
        REQUIRED_VARS
        TiCgtArm_EXECUTABLE
        VERSION_VAR TiCgtArm_VERSION
        )