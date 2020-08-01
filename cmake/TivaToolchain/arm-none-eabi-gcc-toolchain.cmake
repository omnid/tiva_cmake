# Setup the arm-none-eabi-gcc toolchain for Tiva microcontrollers
# https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/CrossCompiling
# (Accessed 5/20/2020) - Be sure to click on expand original content

# The CMAKE_SYSTEM_NAME roughly corresponds to Operating System and controls some files that get automatically executed
# Platform/${CMAKE_SYSTEM_NAME}.cmake
# Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_C_COMPILER_ID}.cmake for compiler specific setup
# Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_C_COMPILER_ID}-${CMAKE_SYSTEM_PROCESSOR}.cmake will do microcontroller model specific setup
# The compiler ID will be GNU-C since this file searches for a gcc compiler
# We use a custom system name and implement our own platform file in ../TivaCMake/Platform
set(CMAKE_SYSTEM_NAME arm-none-eabi)

# By default assume a TM4C123GH6PM microcontroller
set(CMAKE_SYSTEM_PROCESSOR TM4C123GH6PM CACHE STRING "The microcontroller model")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../TivaCMake)
find_package(ArmNoneEabiGCC REQUIRED)

# The user can override these settings to choose a different compiler
set(CMAKE_C_COMPILER ${ArmNoneEabiGCC_C_COMPILER} CACHE STRING "The C compiler")
set(CMAKE_CXX_COMPILER ${ArmNoneEabiGCC_CXX_COMPILER} CACHE STRING "The C++ compiler") 

# Setup search paths for external software that we need that are within the compiler directory
set(CMAKE_FIND_ROOT_PATH "${ArmNoneEabiGCC_ROOT_DIR}")
