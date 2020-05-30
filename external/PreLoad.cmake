# This file runs before almost anything when CMake generates the build system
# We set the module path here so that the module path applies to the toolchain files, which are loaded very early
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake" CACHE INTERNAL "Location to search for CMake files with include or find_package")

