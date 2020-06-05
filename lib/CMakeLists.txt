# Build tivaware and the startup library for each combination of compiler, processor and release mode
# Also install the cmake files
cmake_minimum_required(VERSION 3.9)
project(tiva-cmake NONE)

# List of the supported processor models. Startup code for each model listed here will be generated
list(APPEND processors TM4C123GH6PM)  

find_package(TivaCMake
  HINTS ${CMAKE_CURRENT_LIST_DIR}/../cmake
  )
find_package(TiCgtArm)
find_package(ArmNoneEabiGCC)


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
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_LIST_DIR}/../cmake/${toolchain}
    -DCMAKE_BUILD_TYPE=${buildtype}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/install
    )
endfunction()

# Build startup libraries with different compilers and build types
#   compiler_id - ID of the compiler, either GNU or TI
#   toolchain - name of the toolchain file
#   buildtype - the CMakeBuildtype to use
#   processor - the processor model
function(startup_libraries compiler_id toolchain buildtype processor)
  ExternalProject_Add(
    startup-${compiler_id}-${buildtype}
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/startup
    CMAKE_ARGS
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_LIST_DIR}/../cmake/${toolchain}
    -DCMAKE_BUILD_TYPE=${buildtype}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/install
    )
endfunction()

if((NOT TiCgtArm_FOUND) AND (NOT ArmNoneEabiGCC_FOUND))
  message(FATAL_ERROR "Could not find a suitable C compiler, eithe ti-cgt or arm-none-eabi-gcc")
endif()

# Build debug and release versions of the tivaware library for each compiler
if(TiCgtArm_FOUND)
  tivaware_libraries(TI ti-cgt-arm-toolchain.cmake Debug)
  tivaware_libraries(TI ti-cgt-arm-toolchain.cmake Release)
  foreach(proc ${processors})
    startup_libraries(TI ti-cgt-arm-toolchain.cmake Debug ${proc})
    startup_libraries(TI ti-cgt-arm-toolchain.cmake Release ${proc})
  endforeach()
else()
  message(NOTICE "ti-cgt compiler not found, not building ti-cgt libraries")
endif()

if(ArmNoneEabiGCC_FOUND)
  tivaware_libraries(GNU arm-none-eabi-gcc-toolchain.cmake Debug)
  tivaware_libraries(GNU arm-none-eabi-gcc-toolchain.cmake Release)
  foreach(proc ${processors})
    startup_libraries(GNU arm-none-eabi-gcc-toolchain.cmake Debug ${proc})
    startup_libraries(GNU arm-none-eabi-gcc-toolchain.cmake Release ${proc})
  endforeach()
else()
  message(NOTICE "arm-none-eabi-gcc compiler not found, not building gcc libraries")
endif()

# Install the CMake Files to the local directory
ExternalProject_Add(
  tiva-cmake
  SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../cmake
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/install
    )