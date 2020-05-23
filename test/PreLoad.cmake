# This file runs before almost anything when CMake generates the build system
# Setup module paths so that the cmake files that come with this module can be foudn by toolchain files
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} CACHE INTERNAL "The module path")
