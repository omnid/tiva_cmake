# This file runs before almost anything when CMake generates the build system
# The exact behavior of this file is unspecified https://gitlab.kitware.com/cmake/cmake/-/issues/17231
# but this is the only way I know of to specify a toolchain file without the user specifying flags and
# it also lets me setup a search path for toolchain files

# Detect if tiva_cmake is installed 
find_package(TivaCMake QUIET)

# The default toolchain to use
set(DEFAULT_TOOLCHAIN tiva-toolchain.cmake)


# if TivaCMake is not found then tiva-cmake has not been installed and so we add the local build to the prefix and module paths
if(NOT TivaCMAKE_FOUND)
  set(TivaCMake_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR}/../lib/build/install/share/tiva-cmake)
  # Assume we are in template mode and add the proper paths to the local lib installation.
  # The variables must be cached for them to remain when the CMakeLists.txt is processed
  set(CMAKE_MODULE_PATH ${TivaCMake_ROOT_DIR}/cmake CACHE INTERNAL "Module Path for local installation of tiva-cmake")
  set(CMAKE_PREFIX_PATH ${TivaCMake_ROOT_DIR}/cmake CACHE INTERNAL "Prefix Path for local installation of tiva-cmake")
endif()

# if a toolchain is specified but does not exist, assume that it is referring to a toolchian file in tiva-cmake
# This is because toolchain files must usually be specified either relative to the source directory or absolute
if(CMAKE_TOOLCHAIN_FILE)
  if((NOT (EXISTS ${CMAKE_TOOLCHAIN_FILE})) AND (NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${CMAKE_TOOLCHAIN_FILE}))
    set(CMAKE_TOOLCHAIN_FILE "${TivaCMake_ROOT_DIR}/cmake/${CMAKE_TOOLCHAIN_FILE}" CACHE FILEPATH "The toolchain file")
  endif()
endif()

set(CMAKE_TOOLCHAIN_FILE "${TivaCMake_ROOT_DIR}/cmake/${DEFAULT_TOOLCHAIN}" CACHE FILEPATH "The default toolchain file")

