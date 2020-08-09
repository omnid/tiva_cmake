# Used to install the cmake files for tiva_cmake
cmake_minimum_required(VERSION 3.12)
project(TivaCMakeFiles LANGUAGES NONE)


install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/TivaCMake
  DESTINATION share)

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/TivaToolchain
  DESTINATION share)
