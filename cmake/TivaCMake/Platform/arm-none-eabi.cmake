# This is a platform definition file for the arm-none-eabi platform
# This is an arm cortex M4 processor with no operating system
# It is used when CMAKE_SYSTEM_NAME == "arm-none-eabi"
# Shared libraries are not supported
set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS FALSE)

set(CMAKE_C_LIBRARY_ARCHITECTURE arm-none-eabi)
set(CMAKE_CXX_LIBRARY_ARCHITECTURE arm-none-eabi)
set(CMAKE_SYSTEM_PREFIX_PATH "/;/usr;/usr/local")
# only find programs on the host, since the purpose of finding a program is to run it
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# find library, include directories, and packages in either compiler-specific or on the host
# Libraries for arm-none-eabi can be installed in lib/arm-none-eabi for example
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)
