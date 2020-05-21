# Setup the arm-none-eabi-gcc toolchain for Tiva microcontrollers
# https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/CrossCompiling (Accessed 5/20/2020)
#   - Be sure to click on expand original content
# Platform/Tiva.cmake will be sourced for tiva specific setup (mostly just the Generic platform)
# Platform/Tiva-GNU_C.cmake will be sourced for gcc specific setup
# Platform/Tiva-GNU_C-<model> will do microcontroller model specific setup
set(CMAKE_SYSTEM_NAME arm-none-eabi)   
set(CMAKE_SYSTEM_PROCESSOR TM4C123GH6PM CACHE STRING "The microcontroller model")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
find_package(ArmNoneEabiGCC)

# The user can override these settings to choose a different compiler
set(CMAKE_C_COMPILER ${ArmNoneEabiGCC_C_COMPILER} CACHE STRING "The C compiler")
set(CMAKE_CXX_COMPILER ${ArmNoneEabiGCC_CXX_COMPILER} CACHE STRING "The C++ compiler") 

# Setup search paths for external software that we need
set(CMAKE_FIND_ROOT_PATH "${ArmNoneEabiGCC_ROOT_DIR}")
# only find programs on the host
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# only find library and include directories that are for the embedded system
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

