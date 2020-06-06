# Ensure that dependencies are up to date and then build the src directory
cmake_minimum_required(VERSION 3.9)
project(tiva-cmake LANGUAGES NONE)
add_subdirectory(lib)

install(DIRECTORY ${CMAKE_BINARY_DIR}/install/share
  DESTINATION ".")

