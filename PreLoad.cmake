# This file runs before almost anything when CMake generates the build system
# The exact semantics of this file are unspecified https://gitlab.kitware.com/cmake/cmake/-/issues/17231
# but this is the only way I know of to specify a toolchain file without the user specifying flags
# Used to find modules for the toolchain when building
# the toolchain to use
set(CMAKE_TOOLCHAIN_FILE cmake/tiva-toolchain.cmake CACHE FILEPATH "The default toolchain file")

