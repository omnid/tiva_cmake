# Setup the arm-none-eabi-gcc toolchain for Tiva microcontrollers
# https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/CrossCompiling
# (Accessed 5/20/2020) - Be sure to click on expand original content

# The CMAKE_SYSTEM_NAME roughly corresponds to Operating System and controls some files that get automatically executed
# Platform/${CMAKE_SYSTEM_NAME}.cmake
# Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_C_COMPILER_ID}.cmake for compiler specific setup
# Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_C_COMPILER_ID}-${CMAKE_SYSTEM_PROCESSOR}.cmake will do microcontroller model specific setup
# The compiler ID will be GNU-C since this file searches for a gcc compiler
set(CMAKE_SYSTEM_NAME Generic)
# The Generic platform is built into CMake (and therefore your cmake installation contains a Platform/Generic.cmake) and
# is used because bare-metal microcontrollers have no operating system.
# The built-in Generic.cmake disbables shared libraries since platforms with no OS usually have no shared libraries.
# The platform could also to something not predefined by cmake (e.g., Tiva).
# This might be done in the future if we have Tiva-specific options that apply to all models. For now, Generic.cmake suffices
# since all setup is done in microcontroller model specific files.
# If you were to write a Platform/Tiva.cmake, use set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS FALSE) to disable shared libraries

# By default assume a TM4C123GH6PM microcontroller
set(CMAKE_SYSTEM_PROCESSOR TM4C123GH6PM CACHE STRING "The microcontroller model")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../TivaCMake)
find_package(ArmNoneEabiGCC REQUIRED)

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


