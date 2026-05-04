cmake_minimum_required(VERSION 3.28)
project(TivaCMakeFiles
  VERSION 1.0.0
  DESCRIPTION "CMake Files used for compiling and loading code to Tiva microcontrollers"
  LANGUAGES NONE)

# Install the CMakeFiles that make the toolchain work
install(DIRECTORY TivaCMake TYPE DATA)
install(DIRECTORY TivaStartup TYPE DATA)

# Create scripts that print the path to the toolchain files

# tiva-toolchain is a shortcut that defaults to gcc and falls back on ti if needed
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/scripts/tiva-toolchain.in tiva-toolchain)

# This is the ti compiler toolchain file
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/scripts/ti-cgt-arm-toolchain.in ti-cgt-arm-toolchain)

# This is the gcc compiler toolchain file
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/scripts/arm-none-eabi-gcc-toolchain.in arm-none-eabi-gcc-toolchain)

# Install the scripts
install(PROGRAMS
  ${CMAKE_CURRENT_BINARY_DIR}/tiva-toolchain
  ${CMAKE_CURRENT_BINARY_DIR}/arm-none-eabi-gcc-toolchain
  ${CMAKE_CURRENT_BINARY_DIR}/ti-cgt-arm-toolchain
  TYPE BIN)
