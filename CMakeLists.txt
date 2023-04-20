# Ensure that dependencies are up to date and then build the src directory
cmake_minimum_required(VERSION 3.12)
project(tiva_cmake
  VERSION 0.2.0
  DESCRIPTION "CMake Files for working with Tiva microcontrollers"
  HOMEPAGE_URL "https://github.com/omnid/tiva_cmake"
  LANGUAGES NONE)

add_subdirectory(lib)

# Building lib installs a bunch of external projects to a single directory
# In the prefix ${CMAKE_BINARY_DIR}/install
# We now want to install that into this project's install prefix
install(DIRECTORY ${CMAKE_BINARY_DIR}/install/share
  DESTINATION ".")

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/src
  DESTINATION share/TivaCMake
  PATTERN build EXCLUDE
  )

configure_file(${CMAKE_CURRENT_LIST_DIR}/scripts/tiva-toolchain.in tiva-toolchain)
configure_file(${CMAKE_CURRENT_LIST_DIR}/scripts/ti-cgt-arm-toolchain.in ti-cgt-arm-toolchain)
configure_file(${CMAKE_CURRENT_LIST_DIR}/scripts/arm-none-eabi-gcc-toolchain.in arm-none-eabi-gcc-toolchain)
install(PROGRAMS
  ${CMAKE_CURRENT_BINARY_DIR}/tiva-toolchain
  ${CMAKE_CURRENT_BINARY_DIR}/arm-none-eabi-gcc-toolchain
  ${CMAKE_CURRENT_BINARY_DIR}/ti-cgt-arm-toolchain
  DESTINATION bin
  )

find_package(cmakeme QUIET)
if(cmakeme_FOUND)
  cmakeme_package(EMAIL elwin@u.northwestern.edu
                  ARCH_ANY 
                  DEBIAN_DEPENDS gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib
                  DEBIAN_RECOMMENDS gdb-multiarch
                  ARCHLINUX_DEPENDS arm-none-eabi-gcc arm-none-eabi-newlib
                  ARCHLINUX_RECOMMENDS arm-none-eabi-gdb ti-cgt-arm
                )
else()
  message(STATUS "cmakeme not found, you won't be able to build binary packages with cpack")
endif()

include(CTest)
add_test(NAME null_test COMMAND echo "TODO: No unit tests exist for tiva_cmake")
