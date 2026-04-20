cmake_minimum_required(VERSION 3.28)
project(TivaCMakeFiles
  VERSION 1.0.0
  DESCRIPTION "CMake Files used for compiling and loading code to Tiva microcontrollers"
  LANGUAGES NONE)


install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/TivaCMake TYPE DATA)

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/TivaToolchain TYPE DATA)
