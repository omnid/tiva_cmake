# Ensure that dependencies are up to date and then build the src directory
cmake_minimum_required(VERSION 3.9)
project(tiva-cmake LANGUAGES NONE)

add_subdirectory(lib)

# Building lib installs a bunch of external projects to a single directory
# In the prefix ${CMAKE_BINARY_DIR}/install
# We now want to install that into this project's install prefix
install(DIRECTORY ${CMAKE_BINARY_DIR}/install/share
  DESTINATION ".")

