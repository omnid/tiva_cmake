# Build tivaware and the example code
# If using tiva-cmake as a template, you likely want to edit the files in src/
# It is unlikely that you need to modify this file unless you are working on tiva-cmake itself
cmake_minimum_required(VERSION 3.9)
project(tiva-cmake)

# We build each combination of library/compiler as an external project
include(ExternalProject)

# Build tivaware libraries (tivaware and the startup code) with different compiler combinations
#   compiler_id - ID of the compiler, either GCC or TI
#   toolchain - name of the toolchain file
#   buildtype - the CMakeBuildtype to use
function(tivaware_libraries compiler_id toolchain buildtype)
  ExternalProject_Add(
    tivaware-${compiler_id}-${buildtype}
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/tivaware
    CMAKE_ARGS
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_LIST_DIR}/cmake/${toolchain}
    -DCMAKE_BUILD_TYPE=${buildtype}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/install
    )
endfunction()

# Build startup libraries with different compilers and build types
#   compiler_id - ID of the compiler, either GNU or TI
#   toolchain - name of the toolchain file
#   buildtype - the CMakeBuildtype to use
#   processor - the processor model
function(startup_libraries_proc compiler_id toolchain buildtype processor)
  ExternalProject_Add(
    startup-${compiler_id}-${buildtype}
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/lib
    CMAKE_ARGS
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_LIST_DIR}/cmake/${toolchain}
    -DCMAKE_BUILD_TYPE=${buildtype}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/install
    )
endfunction()

# Build startup libraries for each processor using different compilers and build types
#    processor - the processor model to use
function(startup_libraries processor)
  startup_libraries_proc(TI ti-cgt-arm-toolchain.cmake Debug processor)
  startup_libraries_proc(TI ti-cgt-arm-toolchain.cmake Release processor)
  #startup_libraries_proc(TI ti-cgt-arm-toolchain.cmake Debug processor)
  #startup_libraries_proc(TI ti-cgt-arm-toolchain.cmake Release processor)
endfunction()

# Build debug and release versions of the tivaware library for each compiler
tivaware_libraries(TI ti-cgt-arm-toolchain.cmake Debug)
tivaware_libraries(TI ti-cgt-arm-toolchain.cmake Release)
tivaware_libraries(GNU arm-none-eabi-gcc-toolchain.cmake Debug)
tivaware_libraries(GNU arm-none-eabi-gcc-toolchain.cmake Release)

startup_libraries(TM4C123GH6PM)


# Options for which version of driverlib to use


# Add the tivaware and startup code for this configuration to the module path
#ExternalProject_Get_Property(tivaware-${CMAKE_C_COMPILER_ID}-${CMAKE_BUILD_TYPE} INSTALL_DIR)
#message(INFO "POOPSIGN ${INSTALL_DIR}")
#list(APPEND CMAKE_MODULE_PATH 
#add_subdirectory(src)
