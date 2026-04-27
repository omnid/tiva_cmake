cmake_minimum_required(VERSION 3.12)
project(tiva_cmake
  VERSION 0.2.0
  DESCRIPTION "CMake Files for working with Tiva microcontrollers"
  HOMEPAGE_URL "https://github.com/omnid/tiva_cmake"
  LANGUAGES NONE)

# Determine whether to build this for the GNU and TI compilers
option(BUILD_GNU "Build GNU (arm-none-eabi-gcc) support" ON)
option(BUILD_TI "Build TI (ti-cgt-arm) support" OFF)

include(CTest)
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

# This target can be used as a dependency of any testing code that is created by this project
# It ensures that the testing code is run in the context of a full (as opposed to partial)
# tiva_cmake installation (in other words, the startup and tivaware libraries are available)
add_custom_target(tiva_cmake)


# Build tivaware libraries (tivaware and the startup code) with different compiler combinations
#   compiler_id - ID of the compiler, (GCC or TI)
#   build_type - the CMakeBuildtype to use (Debug or Release)
function(startup_libraries compiler_id build_type)
  ExternalProject_Add(${compiler_id}_${build_type}_startup
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/startup
    PREFIX prefix
    INSTALL_DIR install
    DEPENDS tiva_toolchain
    CMAKE_ARGS
    -DCMAKE_PREFIX_PATH=<INSTALL_DIR>
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${build_type}
    -DCMAKE_TOOLCHAIN_FILE=<SOURCE_DIR>/cmake/${compiler_id}-toolchain.cmake)
  add_dependencies(tiva_cmake ${compiler_id}_${build_type}_startup)
endfunction()


# Build tivaware libraries (tivaware and the startup code) with different compiler combinations
#   compiler_id - ID of the compiler, (GCC or TI)
#   build_type - the CMakeBuildtype to use (Debug or Release)
function(tivaware_libraries compiler_id build_type)
  ExternalProject_Add(${compiler_id}_${build_type}_tivaware
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tivaware
    PREFIX prefix
    INSTALL_DIR install
    DEPENDS tiva_toolchain ${compiler_id}_${build_type}_startup
    CMAKE_ARGS
    -DCMAKE_PREFIX_PATH=<INSTALL_DIR>
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${build_type}
    -DCMAKE_TOOLCHAIN_FILE=<SOURCE_DIR>/cmake/${compiler_id}-toolchain.cmake
    )
  add_dependencies(tiva_cmake ${compiler_id}_${build_type}_tivaware)
endfunction()

#-------------------- Build the startup and tivaware libraries ------------------------------#
# Create all the supported varieties of startup library
if(BUILD_GNU)
  startup_libraries(GNU Debug)
  startup_libraries(GNU Release)
  tivaware_libraries(GNU Debug)
  tivaware_libraries(GNU Release)

  if(BUILD_TESTING)
    # Build the GNU example, a successful build is the test here
    # Note: All example's and tests that use TivaCMake should depend
    # on a tivaware library even if
    ExternalProject_Add(GNU_example
      SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/example
      PREFIX prefix
      INSTALL_DIR install
      INSTALL_COMMAND ""
      DEPENDS tiva_cmake
      CMAKE_ARGS
      -DCMAKE_PREFIX_PATH=<INSTALL_DIR>
      -DCMAKE_TOOLCHAIN_FILE=<SOURCE_DIR>/cmake/GNU-toolchain.cmake)

    # Build the startup code test
    ExternalProject_Add(GNU_startup_test
      SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/test
      PREFIX prefix
      INSTALL_DIR install
      BINARY_DIR test
      INSTALL_COMMAND ""
      DEPENDS tiva_cmake
      CMAKE_ARGS
      -DCMAKE_PREFIX_PATH=<INSTALL_DIR>
      -DCMAKE_TOOLCHAIN_FILE=<SOURCE_DIR>/cmake/GNU-toolchain.cmake
    )

    find_program(QEMU_ARM qemu-system-arm REQUIRED)
    find_program(GDB NAMES arm-none-eabi-gdb gdb-multiarch REQUIRED)

    add_test(NAME qemu_startup_test
      COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/test/qemu_gdb_test.sh
      ${QEMU_ARM}
      ${GDB}
      ${CMAKE_BINARY_DIR}/test/startup_test
      ${CMAKE_CURRENT_SOURCE_DIR}/test/startup_test.gdb)
  endif()
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
