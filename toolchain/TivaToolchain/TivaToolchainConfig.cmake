# Distributed under the LICENSE found in tiva_cmake/LICENSE
#[========================================================================[.rst:
TivaToolchainConfig
--------------------------

Enables finding the TivaToolchain directory and toolchain files.

Result Variables
^^^^^^^^^^^^^^^^

Set's the following variables

``TivaToolchain_FOUND``
  Set by find_package to indicate that the toolchain has been found

``TivaToolchain_DIR``
  The directory of the tiva toolchain files

``TivaToolchain_GNU``
  Full path to the GNU compiler toolchain file

``TivaToolchain_TI``
Full path to the TI Compiler toolchain file


Notes
--------

The results variables are preserved in TivaCMake/Platform/arm-none-eabi.cmake via CMAKE_TRY_COMPILE_PLATFORM_VARIABLES, enabling
them to persist when the toolchain is reloaded by try compile.
#]========================================================================]
# A guide for writing find modules: https://cmake.org/cmake/help/v3.17/manual/cmake-developer.7.html

if(TivaToolchain_FOUND)
  return()
endif()

# These variables need to be set at file scope so they are preserved
# When the TivaCMake/Platform/arm-none-eabi.cmake file is called
set(TivaToolchain_GNU ${TivaToolchain_DIR}/arm-none-eabi-gcc-toolchain.cmake)
set(TivaToolchain_TI ${TivaToolchain_DIR}/ti-cgt-arm-toolchain.cmake)
