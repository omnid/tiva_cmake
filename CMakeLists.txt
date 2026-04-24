cmake_minimum_required(VERSION 3.12)
project(tiva_cmake
  VERSION 0.2.0
  DESCRIPTION "CMake Files for working with Tiva microcontrollers"
  HOMEPAGE_URL "https://github.com/omnid/tiva_cmake"
  LANGUAGES NONE)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "In-source builds are not allowed.")
endif()

# Determine whether to build this for the GNU and TI compilers
option(BUILD_GNU "Build GNU (arm-none-eabi-gcc) support" ON)
option(BUILD_TI "Build TI (ti-cgt-arm) support" OFF)


include(ExternalProject)

#----------- Install the CMake Files for the Toolchain ----------------#
#     All other cross-compilation depends on these cmake files
ExternalProject_Add(
  tiva_toolchain
  PREFIX prefix
  INSTALL_DIR install
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/toolchain
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>)

#------------  Helper functions for building startup and tivaware libraries ----------------#

# Build tivaware libraries (tivaware and the startup code) with different compiler combinations
#   compiler_id - ID of the compiler, (GCC or TI)
#   build_type - the CMakeBuildtype to use (Debug or Release)
function(startup_libraries compiler_id build_type)
  ExternalProject_Add(${compiler_id}_${build_type}_startup
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/startup
    PREFIX prefix
    INSTALL_DIR install
    CMAKE_ARGS
    -DCMAKE_PREFIX_PATH=<INSTALL_DIR>
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${build_type}
    -DCMAKE_TOOLCHAIN_FILE=<SOURCE_DIR>/cmake/${compiler_id}-toolchain.cmake)
endfunction()


# Build tivaware libraries (tivaware and the startup code) with different compiler combinations
#   compiler_id - ID of the compiler, (GCC or TI)
#   build_type - the CMakeBuildtype to use (Debug or Release)
function(tivaware_libraries compiler_id build_type)
  ExternalProject_Add(${compiler_id}_${build_type}_tivaware
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tivaware
    PREFIX prefix
    INSTALL_DIR install
    CMAKE_ARGS
    -DCMAKE_PREFIX_PATH=<INSTALL_DIR>
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${build_type}
    -DCMAKE_TOOLCHAIN_FILE=<SOURCE_DIR>/cmake/${compiler_id}-toolchain.cmake
    )
endfunction()

#-------------------- Build the startup and tivaware libraries ------------------------------#

# Create all the supported varieties of startup library
if(BUILD_GNU)
  startup_libraries(GNU Debug)
  startup_libraries(GNU Release)
  tivaware_libraries(GNU Debug)
  tivaware_libraries(GNU Release)
endif()

if(BUILD_TI)
  startup_libraries(TI Debug)
  startup_libraries(TI Release)
  tivaware_libraries(TI Debug)
  tivaware_libraries(TI Release)
endif()

#---------------------- Installation -----------------------#
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/install/
  DESTINATION .
  USE_SOURCE_PERMISSIONS)

include(CTest)
add_test(NAME null_test COMMAND echo "TODO: No unit tests exist for tiva_cmake")
