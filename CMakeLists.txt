# Ensure that dependencies are up to date and then build the src directory
cmake_minimum_required(VERSION 3.9)
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

set(CPACK_GENERATOR "TGZ;ZIP;DEB;RPM")
set(CPACK_SYSTEM_NAME "Generic")
set(CPACK_PACKAGE_CONTACT "elwin@northwestern.edu")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "all")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "gcc-arm-none-eabi;libnewlib-arm-none-eabi;openocd")
set(CPACK_DEBIAN_PACKAGE_RECOMMENDS "gdb-multiarch")
include(CPack)
