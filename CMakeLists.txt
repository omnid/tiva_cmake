# Ensure that dependencies are up to date and then build the src directory
cmake_minimum_required(VERSION 3.12)
project(tiva_cmake
  VERSION 0.2.0
  DESCRIPTION "CMake Files for working with Tiva microcontrollers"
  HOMEPAGE_URL "https://github.com/omnid/tiva_cmake"
  LANGUAGES NONE)

include(ExternalProject)

# Install the CMakeFiles for the toolchain as a local dependency
# The rest of the build depends on having these files
# All other cross-compilation depends on these cmake files
ExternalProject_Add(
  tiva_toolchain
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/toolchain
  INSTALL_DIR ${CMAKE_BINARY_DIR}/deps
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>)

#ExternalProject_Get_Property(tiva_toolchain 

#ExternalProject_Add(GNU_Debug_startup
#  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/startup
#  CMAKE_ARGS
#  -DCMAKE_PREFIX_PAT
#  -DCMAKE_TOOLCHAIN_FILE=
#  -DCMAKE_BUILD_TYPE=Debug
#  -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>)

#    startup_libraries(TI ti-cgt-arm-toolchain.cmake Debug ${proc})


  
#1 add_subdirectory(lib)

# Building lib installs a bunch of external projects to a single directory
# In the prefix ${CMAKE_BINARY_DIR}/install
# We now want to install that into this project's install prefix
#1 install(DIRECTORY ${CMAKE_BINARY_DIR}/install/share
#1  DESTINATION ".")

#1 install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/src
#1  DESTINATION share/TivaCMake
#1  PATTERN build EXCLUDE
#1  )

#1 configure_file(${CMAKE_CURRENT_LIST_DIR}/scripts/tiva-toolchain.in tiva-toolchain)
#1 configure_file(${CMAKE_CURRENT_LIST_DIR}/scripts/ti-cgt-arm-toolchain.in ti-cgt-arm-toolchain)
#1 configure_file(${CMAKE_CURRENT_LIST_DIR}/scripts/arm-none-eabi-gcc-toolchain.in arm-none-eabi-gcc-toolchain)
#1 install(PROGRAMS
#1   ${CMAKE_CURRENT_BINARY_DIR}/tiva-toolchain
#1   ${CMAKE_CURRENT_BINARY_DIR}/arm-none-eabi-gcc-toolchain
#1   ${CMAKE_CURRENT_BINARY_DIR}/ti-cgt-arm-toolchain
#1   DESTINATION bin
#1   )


#1 include(CTest)
#1 add_test(NAME null_test COMMAND echo "TODO: No unit tests exist for tiva_cmake")
