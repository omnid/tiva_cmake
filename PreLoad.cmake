# This file runs before almost anything when CMake generates the build system
# Used to find modules for the toolchain when building
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake" CACHE INTERNAL "Location to search for CMake files with include or find_package")

# Set to enable find_package from within src/ to find the packages built with this project
set(CMAKE_PREFIX_PATH "${CMAKE_CURRENT_BINARY_DIR}/external/install/share/tiva-cmake/cmake" CACHE INTERNAL "Path to external install directory")

# the toolchain to use
set(CMAKE_TOOLCHAIN_FILE cmake/tiva-toolchain.cmake CACHE FILEPATH "The default toolchain file")

