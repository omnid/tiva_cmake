# Used to install the cmake files for tiva-cmake
cmake_minimum_required(VERSION 3.9)
project(TivaCMakeFiles LANGUAGES NONE)

# Set system name so GNUInstallDirs knows what directoreis to use
set(CMAKE_SYSTEM_NAME ${CMAKE_HOST_NAME})
include(GNUInstallDirs)

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/TivaCMake
  DESTINATION ${CMAKE_INSTALL_DATADIR})

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/TivaToolchain
  DESTINATION ${CMAKE_INSTALL_DATADIR})
