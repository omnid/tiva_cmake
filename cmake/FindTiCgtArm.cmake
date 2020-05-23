# Distributed under the LICENSE found in tiva-cmake/LICENSE
#[========================================================================[.rst:
FindTiCgtArm
----------------------

Finds the TI cgt compiler for arm microprocessors.
Search in the following order:
1. Locally installed versions `/home/$(whoami)/ti/ti-cgt-arm*` and `/home/$(whoami)/ti-cgt-arm*`
2. Globally installed versions: `/opt/ti/ti-cgt-arm*` `/opt/ti-cgt-arm*`, and the system path
3. Code Composer Studio (if installed). 

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``TiCgtArm_FOUND``
  True if the system has ti-cgt-arm installed

``TiCgtArm_VERSION``
  The version of ti-cgt-arm that was found.

``TiCgtArm_LIBRARY_DIRS``
  Location of the C standard library

``TiCgtArm_INCLUDE_DIRS``
  Include directories for the C standard library

``TiCgtArm_SOURCE_DIRS``
  Directory with source code for the C standard library

``TiCgtArm_ROOT_DIR``
  The root directory of the ti-cgt arm compiler

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``TiCgtArm_EXECUTABLE``
  The C and C++ compiler executable.


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

file(GLOB TiCgtArm_HINTS4 /opt/ti-cgt-arm*)
list(REVERSE TiCgtArm_HINTS4)

file(GLOB TiCgtArm_HINT_CCS ${CodeComposerStudio_ROOT_DIR}/ccs*/tools/compiler/ti-cgt-arm*)
list(REVERSE TiCgtArm_HINT_CCS)
          
find_program(TiCgtArm_EXECUTABLE
        NAMES armacl
        HINTS ${TiCgtArm_HINTS1} ${TiCgtArm_HINTS2} ${TiCgtArm_HINTS3} ${TiCgtArm_HINTS4}
        DOC "armcl (the ti-cgt compiler frontend): it's location tells the toolchain where to find ti-cgt "
        PATH_SUFFIXES bin
        )

 if( "${TiCgtArm_EXECUTABLE}" STREQUAL "TiCgtArm_EXECUTABLE-NOTFOUND")
   find_program(TiCgtArm_EXECUTABLE
         NAMES armcl
         HINTS ${TiCgtArm_HINT_CCS}
         PATH_SUFFIXES bin
         DOC "armcl (the ti-cgt compiler frontend): it's location tells the toolchain where to find ti-cgt "
         NO_DEFAULT_PATH
         )
endif()

# compute paths to the C standard library
get_filename_component(TiCgtArm_BIN_DIR ${TiCgtArm_EXECUTABLE} DIRECTORY)
get_filename_component(TiCgtArm_ROOT_DIR ${TiCgtArm_BIN_DIR}/.. ABSOLUTE)

set(TiCgtArm_INCLUDE_DIRS ${TiCgtArm_ROOT_DIR}/include)
set(TiCgtArm_LIBRARY_DIRS ${TiCgtArm_ROOT_DIR}/lib)
set(TiCgtArm_SOURCE_DIRS ${TiCgtArm_C_LIBRARY_DIRS}/src)

# compute the version, if have found the package
if(NOT "${TiCgtArm_EXECUTABLE}" STREQUAL "TiCgtArm_EXECUTABLE-NOTFOUND")
  get_filename_component(TiCgtArm_VERSION_DIR ${TiCgtArm_ROOT_DIR} NAME)
  string(REGEX REPLACE "ti-cgt-arm." "" TiCgtArm_VERSION ${TiCgtArm_VERSION_DIR})
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TiCgtArm
        FOUND_VAR TiCgtArm_FOUND
        REQUIRED_VARS
        TiCgtArm_EXECUTABLE
        VERSION_VAR TiCgtArm_VERSION
        )
        
