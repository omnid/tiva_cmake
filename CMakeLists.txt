# Ensure that dependencies are up to date and then build the src directory
cmake_minimum_required(VERSION 3.12)
project(tiva-cmake
  VERSION 0.1.0
  DESCRIPTION "CMake Files for working with Tiva microcontrollers"
  HOMEPAGE_URL "https://github.com/m-elwin/tiva-cmake"
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

configure_file(${CMAKE_CURRENT_LIST_DIR}/cpack/PKGBUILD.in ${CMAKE_BINARY_DIR}/archlinux/PKGBUILD @ONLY)
set(CPACK_GENERATOR "TGZ;ZIP;DEB;RPM;External")
set(CPACK_SYSTEM_NAME "any")
set(CPACK_PACKAGE_CONTACT "elwin@northwestern.edu")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "all")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "gcc-arm-none-eabi, libnewlib-arm-none-eabi, openocd")
set(CPACK_DEBIAN_PACKAGE_RECOMMENDS "gdb-multiarch")
# The external target builds the archlinux package
set(CPACK_EXTERNAL_PACKAGE_SCRIPT "${CMAKE_CURRENT_LIST_DIR}/cpack/arch_pkg.cmake")
include(CPack)
