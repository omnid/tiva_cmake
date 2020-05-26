# Build tivaware and the example code
# If using tiva-cmake as a template, you likely want to edit the files in src/
# It is unlikely that you need to modify this file unless you are working on tiva-cmake itself
cmake_minimum_required(VERSION 3.9)
project(tiva-cmake LANGUAGES NONE)

# We build each combination of library/compiler as an external project
include(ExternalProject)

# Build tivaware as an external project
#   compiler - Name of the compiler: either arm-none-eabi-gcc or ti-cgt-arm
#   buildtype - the CMakeBuildtype to use
function(external_tivaware compiler buildtype)
  ExternalProject_Add(
    tivaware-${compiler}-${buildtype}
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/tivaware
    CMAKE_ARGS
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_LIST_DIR}/cmake/${compiler}-toolchain.cmake
    -DCMAKE_BUILD_TYPE=${buildtype}
    -DCMAKE_INSTALL_PREFIX=install
    )
endfunction()

# Build debug and release versions of the tivaware library for each compiler
external_tivaware(ti-cgt-arm Debug)
external_tivaware(ti-cgt-arm Release)
external_tivaware(arm-none-eabi-gcc Debug)
external_tivaware(arm-none-eabi-gcc Release)


