# Build tivaware and the example code
# If using tiva-cmake as a template, you likely want to edit the files in src/
# It is unlikely that you need to modify this file unless you are working on tiva-cmake itself
cmake_minimum_required(VERSION 3.9)
project(tiva-cmake)

# We build each combination of library/compiler as an external project
include(ExternalProject)

# Build external libraries (tivaware and the startup code) with different compiler combinations
#   compiler_id - ID of the compiler, either GCC or TI
#   toolchain - name of the toolchain file
#   buildtype - the CMakeBuildtype to use
function(external_libraries compiler_id toolchain buildtype)
  ExternalProject_Add(
    tivaware-${compiler_id}-${buildtype}
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/tivaware
    CMAKE_ARGS
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_LIST_DIR}/cmake/${toolchain}
    -DCMAKE_BUILD_TYPE=${buildtype}
    -DCMAKE_INSTALL_PREFIX=install
    )

  ExternalProject_Add(
    startup-${compiler_id}-${buildtype}
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/lib
    CMAKE_ARGS
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_LIST_DIR}/cmake/${toolchain}
    -DCMAKE_BUILD_TYPE=${buildtype}
    -DCMAKE_INSTALL_PREFIX=install
    )
endfunction()

# Build debug and release versions of the tivaware library for each compiler
external_libraries(TI ti-cgt-arm Debug)
external_libraries(TI ti-cgt-arm Release)
#external_libraries(GCC arm-none-eabi-gcc Debug)
#external_libraries(GCC arm-none-eabi-gcc Release)

# Add the tivaware and startup code for this configuration to the module path
ExternalProject_Get_Property(tivaware-${CMAKE_C_COMPILER_ID}-${CMAKE_BUILD_TYPE} INSTALL_DIR)
message(INFO "POOPSIGN ${INSTALL_DIR}")
#list(APPEND CMAKE_MODULE_PATH 
#add_subdirectory(src)
