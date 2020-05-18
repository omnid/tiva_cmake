# Distributed under the LICENSE found in tiva-cmake/LICENSE
#[========================================================================[.rst:
FindArmNoneEabiGCC
----------------------

Finds the `arm-none-eabi-gcc` compiler.

Search in the following order:
1. Locally installed versions `/home/$(whoami)/arm-none-eabi-gcc*` `/home/$(whoami)/gcc-arm-none-eabi*`
2. Globally installed versions: `/opt/arm-none-eabi-gcc*`, `/opt/gcc-arm-none-eabi*` and the system path
3. Code Composer Studio (if installed). 


Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``ArmNoneEabiGCC_FOUND``
  True if the system has ti-cgt-arm installed
``ArmNoneEabiGCC_VERSION``
  The version of ti-cgt-arm that was found.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``ArmNoneEabiGCC_EXECUTABLE``
  The C compiler executable, which is used to identify the compiler binary directory

#]========================================================================]
# A guide for writing find modules: https://cmake.org/cmake/help/v3.17/manual/cmake-developer.7.html
find_package(CodeComposerStudio)

# Glob each search directory since the name contains the version of the compiler
# Reverse the results so that the directory with the highest versions are first
file(GLOB ArmNoneEabiGCC_HINTS1 $ENV{HOME}/arm-none-eabi-gcc*)
list(REVERSE ArmNoneEabiGCC_HINTS1)

file(GLOB ArmNoneEabiGCC_HINTS2 $ENV{HOME}/gcc-arm-none-eabi*)
list(REVERSE ArmNoneEabiGCC_HINTS2)

file(GLOB ArmNoneEabiGCC_HINTS3 /opt/arm-none-eabi-gcc*)
list(REVERSE ArmNoneEabiGCC_HINTS3)

file(GLOB ArmNoneEabiGCC_HINTS4 /opt/gcc-arm-none-eabi*)
list(REVERSE ArmNoneEabiGCC_HINTS4)

file(GLOB ArmNoneEabiGCC_HINT_CCS ${CodeComposerStudio_ROOT_DIR}/ccs*/tools/compiler/gcc-arm-none-eabi* ${CodeComposerStudio_ROOT_DIR}/ccs*/tools/compiler/arm-none-eabi-gcc*)
list(REVERSE ArmNoneEabiGCC_HINT_CCS)
          
find_program(ArmNoneEabiGCC_EXECUTABLE
        NAMES arm-none-eabi-gcc
        HINTS ${ArmNoneEabiGCC_HINTS1} ${ArmNoneEabiGCC_HINTS2} ${ArmNoneEabiGCC_HINTS3} ${ArmNoneEabiGCC_HINTS4} 
        DOC "arm-none-eabi-gcc: it's location tells the toolchain where to find all the GNU compiler tools"
        PATH_SUFFIXES bin
        )

 if( "${ArmNoneEabiGCC_EXECUTABLE}" STREQUAL "ArmNoneEabiGCC_EXECUTABLE-NOTFOUND")
   find_program(ArmNoneEabiGCC_EXECUTABLE
         NAMES arm-none-eabi-gcc
         HINTS ${ArmNoneEabiGCC_HINT_CCS}
         PATH_SUFFIXES bin
         DOC "arm-none-eabi-gcc: it's location tells the toolchain where to find all the GNU compiler tools"
         NO_DEFAULT_PATH
         )
endif()

# compute paths to the C standard library
get_filename_component(ArmNoneEabiGCC_BIN_DIR ${ArmNoneEabiGCC_EXECUTABLE} DIRECTORY)
get_filename_component(ArmNoneEabiGCC_ROOT_DIR ${ArmNoneEabiGCC_BIN_DIR}/.. ABSOLUTE)

# compute the version, if have found the package
if(NOT "${ArmNoneEabiGCC_EXECUTABLE}" STREQUAL "ArmNoneEabiGCC_EXECUTABLE-NOTFOUND")
  get_filename_component(ArmNoneEabiGCC_VERSION ${ArmNoneEabiGCC_ROOT_DIR} NAME)
  string(REGEX REPLACE "arm-none-eabi-gcc." "" ArmNoneEabiGCC_VERSION ${ArmNoneEabiGCC_VERSION})
  string(REGEX REPLACE "gcc-arm-none-eabi." "" ArmNoneEabiGCC_VERSION ${ArmNoneEabiGCC_VERSION})
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ArmNoneEabiGCC
        FOUND_VAR ArmNoneEabiGCC_FOUND
        REQUIRED_VARS
        ArmNoneEabiGCC_EXECUTABLE
        VERSION_VAR ArmNoneEabiGCC_VERSION
        )
        
