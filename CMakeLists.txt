# Ensure that dependencies are up to date and then build the src directory
cmake_minimum_required(VERSION 3.12)
project(tiva-cmake
  VERSION 0.2.0
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

configure_file(${CMAKE_CURRENT_LIST_DIR}/scripts/tiva-toolchain.in tiva-toolchain)
configure_file(${CMAKE_CURRENT_LIST_DIR}/scripts/ti-cgt-arm-toolchain.in ti-cgt-arm-toolchain)
configure_file(${CMAKE_CURRENT_LIST_DIR}/scripts/arm-none-eabi-gcc-toolchain.in arm-none-eabi-gcc-toolchain)
install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/tiva-toolchain
  ${CMAKE_CURRENT_BINARY_DIR}/arm-none-eabi-gcc-toolchain
  ${CMAKE_CURRENT_BINARY_DIR}/ti-cgt-arm-toolchain
  DESTINATION bin
  PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  )

cmakeme_package()
