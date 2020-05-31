# Ensure that dependencies are up to date and then build the src directory
cmake_minimum_required(VERSION 3.9)
project(TivaCMakeExternal LANGUAGES NONE)

# TivaWare and other dependencies are built via a external/CMakeLists.txt
# We invoke cmake during configuration time to ensure that these files are
# build prior to attempting to build the project.
# Thus, when this project is configured, another cmake instance is launched
# That configures, builds, and (within the build directory) installs the dependencies

# configure the external cmake processes
execute_process(
  COMMAND ${CMAKE_COMMAND} -S external -B ${CMAKE_CURRENT_BINARY_DIR}/external
  RESULT_VARIABLE CONFIG_SUCCESS
  )

if(NOT CONFIG_SUCCESS EQUAL 0)
  message(FATAL_ERROR "CMake failed to configure the external project dependencies")
endif()

# Build the external libraries
execute_process(
  COMMAND ${CMAKE_COMMAND} --build ${CMAKE_CURRENT_BINARY_DIR}/external
  RESULT_VARIABLE BUILD_SUCCESS
  )

if(NOT CONFIG_SUCCESS EQUAL 0)
  message(FATAL_ERROR "CMake failed to compile the external project dependencies")
endif()

# Set to enable find_package from within src/ to find the packages built with this project and installed in the build directory
set(CMAKE_PREFIX_PATH "${CMAKE_CURRENT_BINARY_DIR}/external/install/share/tiva-cmake/cmake" CACHE INTERNAL "Path to external install directory")
add_subdirectory(src)
