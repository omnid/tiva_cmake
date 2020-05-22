# Setup the arm-none-eabi-gcc toolchain for Tiva microcontrollers
# https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/CrossCompiling (Accessed 5/20/2020)
#   - Be sure to click on expand original content

# The CMAKE_SYSTEM_NAME controls some files that get automatically executed
# Platform/${CMAKE_SYSTEM_NAME}.cmake
# Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_C_COMPILER_ID}.cmake for compiler specific setup
# Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_C_COMPILER_ID}-${CMAKE_SYSTEM_PROCESSOR}.cmake will do microcontroller model specific setup
# The Generic platform is built into CMake (and therefore your cmake installation contains a Platform/Generic.cmake)
# It mainly calls set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS FALSE) to disable shared libraries,
# since platforms with no OS usually have no shared libraries.
# You could also set the platform to something more specific like Tiva, in which case you would need to write
# Platform/Tiva.cmake and call set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS FALSE) to disable shared libraries
# The compiler ID will be GNU-C since this file searches for a gcc compiler
set(CMAKE_SYSTEM_NAME Generic)

# By default assume a TM4C123GH6PM microcontroller
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


