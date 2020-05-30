# During configuration time build all the external libraries and install them
# to a local prefix. Then build the source directory
cmake_minimum_required(VERSION 3.9)
project(TivaCMakeExternal LANGUAGES NONE)

# configure the external cmake processes
execute_process(
  COMMAND ${CMAKE_COMMAND} -S external -B build/external)

# Build the external libraries
execute_process(
  COMMAND ${CMAKE_COMMAND} --build build/external)
