# This file runs before almost anything when CMake generates the build system
# The exact behavior of this file is unspecified https://gitlab.kitware.com/cmake/cmake/-/issues/17231
# but this is the only way I know of to specify a toolchain file without the user specifying flags and
# it also lets me setup a search path for toolchain files

# The default toolchain to use
set(DEFAULT_TOOLCHAIN tiva-toolchain.cmake)

# Detect if tiva_cmake is installed 
find_package(TivaToolchain QUIET)
if(NOT TivaToolchain_FOUND)
  # TivaCMake not in an install prefix, this means tiva-cmake has not been installed and we expected the installation to be in the local directory
  set(CMAKE_PREFIX_PATH "${CMAKE_CURRENT_LIST_DIR}/../lib/build/install/" CACHE FILEPATH "List of locations to search for yyyConfig.cmake with find_package")
  find_package(TivaToolchain REQUIRED)
endif()  


#if a toolchain is specified but does not exist, assume that it is referring to a toolchain file in the tiva-cmake project
# This is because toolchain files must usually be specified either relative to the source directory or absolute
if(CMAKE_TOOLCHAIN_FILE)
  if((NOT (EXISTS ${CMAKE_TOOLCHAIN_FILE})) AND (NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${CMAKE_TOOLCHAIN_FILE}))
    set(CMAKE_TOOLCHAIN_FILE "${TivaToolchain_DIR}/${CMAKE_TOOLCHAIN_FILE}" CACHE FILEPATH "The toolchain file" FORCE)
  endif()
endif()

set(CMAKE_TOOLCHAIN_FILE "${TivaToolchain_DIR}/${DEFAULT_TOOLCHAIN}" CACHE FILEPATH "The default toolchain file")

