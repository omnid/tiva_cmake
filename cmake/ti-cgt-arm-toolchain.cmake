# Toolchain file for the ti-cgt-arm compiler.
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR TM4C123GH6PM CACHE STRING "The microcontroller model")

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
find_package(TiCgtArm)


# only set if not set otherwise the user is overriding
set(CMAKE_C_COMPILER ${TiCgtArm_EXECUTABLE} CACHE STRING "C compiler version")
set(CMAKE_CXX_COMPILER ${TiCgtArm_EXECUTABLE} CACHE STRING "CXX compiler version") # the ti c and c++ compilers are the same I think

# Setup search paths for external software that we need
set(CMAKE_FIND_ROOT_PATH "${TiCgtArm_ROOT_DIR}/..")
# only find programs on the host
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# only find library and include directories that are for the embedded system
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

