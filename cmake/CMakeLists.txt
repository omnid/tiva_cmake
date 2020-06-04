# Used to install the cmake files for tiva-cmake
cmake_minimum_required(VERSION 3.9)
project(TivaCMakeFiles LANGUAGES NONE)

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
  DESTINATION share/TivaCMake)
