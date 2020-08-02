# Basic template for using tiva-cmake
# Edit this file to add your own executables and c files.
# Lines to modify are marked with Edit:
cmake_minimum_required(VERSION 3.12)
# EDIT below to change the name of the cmake project 
project(LedExample)

# Make TivaCMake's features available to this file 
find_package(TivaCMake)

#-------------------- This section is optional and contains some opinionated settings-----------------------------------------
# Some default settings I like to use but don't belong in the Platform file because they are not necessary for compilation.

# Use C99 and C++17 without gnu extensions
# These could be set on a per-target basis, but I typically want these settings for every project

# Disable in-source builds, a separate build directory is always required. Doing an in-source build
# by accident makes a mess.
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(FATAL_ERROR
      "No in source builds allowed. Create a separate build directory.
       SOURCE_DIR=${CMAKE_SOURCE_DIR}  BINARY_DIR=${CMAKE_BINARY_DIR} ")
endif()

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_CXX_EXTENSIONS OFF)

# If build type is blank and we are on a single configuration generator set build type to default
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "The build type" FORCE)

  # These are possibile values for CMAKE_BUILD_TYPE that display in the cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# General compile options used by the whole project.
# compile options and features for gcc 
add_compile_options("$<$<C_COMPILER_ID:GNU>:-pedantic;-Wall;-Wextra>")

# This should really be it's own build type, but it makes sense to turn gcc debugging optimizations on
# The gcc manual says -Og should be the default build type for debugging
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  add_compile_options("$<$<C_COMPILER_ID:GNU>:-Og>")
endif()

# extra default compiler options when using the TI based compiler.
# CMAKE does not offer compiler features for TI compilers so we
# specify the flags manually
# pden - show error numbers (makes it easier to get help with errors)
# pdr - show remarks        
# pdv - verbose diagnostics
# c99 - use c99 mode
# diag_suppress=270 - don't issue remark if variables declared after executable 
#        statements. This practice is explicitly allowed by c99
add_compile_options("$<$<C_COMPILER_ID:TI>:-pden;-pdr;-pdv;--c99;--diag_suppress=270>")
#----------------------- End Optional Section --------------------------------------------------------


# EDIT below to change the name of the executable and what source files compose it
add_executable(led_example main.c) 

# EDIT below if you use any other libraries or changed the name of the executable
# Link against the startup code and driverlib
# NOTE: when making a library, you should only use TivaCMake::startup as INTERFACE linkage not PUBLIC or PRIVATE
# Otherwise, its code gets put in the archive and then will be discarded when linking with the executable.
# See README.org
target_link_libraries(led_example TivaCMake::driverlib TivaCMake::startup)

