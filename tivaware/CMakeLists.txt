# CMake Build for tivaware driverlib
cmake_minimum_required(VERSION 3.9)
project(TivaWare)
include(GNUInstallDirs)

# Usually it is bad practice to glob, but here the files we need are designed
# to be donloaded from within code composer studio and copied and there is
# more danger in missing a new file that is added whenever driverlib is updated
file(GLOB DRIVERLIB_SOURCE driverlib/*.c)

add_library(driverlib ${DRIVERLIB_SOURCE})

# root installation directory
set(INSTALL_ROOT ${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware)


target_include_directories(driverlib PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:${INSTALL_ROOT}>)


# All librareis are installed to usr/share since the files are not for the host platform
# There are different installation paths for the Debug and Release configurations
# And the path depends on the compiler, so all versions can be installed simultaneously
# We duplicate the install command for each configuration to make this file compatible
# with multi-configuration generators (such as visual studio)
# The Targets are also labeled by build type
install(TARGETS driverlib
  EXPORT TivaWareTargets_Debug
  CONFIGURATIONS Debug
  LIBRARY DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}
  ARCHIVE DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}
  )

install(TARGETS driverlib
  EXPORT TivaWareTargets_Release
  CONFIGURATIONS Release
  LIBRARY DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}
  ARCHIVE DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}
  )

install(DIRECTORY inc
  DESTINATION ${INSTALL_ROOT})

install(EXPORT TivaWareTargets_Debug
  NAMESPACE TivaWare::
  CONFIGURATIONS Debug
  DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}
  )

install(EXPORT TivaWareTargets_Release
  NAMESPACE TivaWare::
  CONFIGURATIONS Release
  DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}
  )

# The TivaWareConfig.cmake file imports the targets based on the value of DRIVERLIB_DEBUG and what
# compiler is being used
configure_file(TivaWareConfig.cmake.in TivaWareConfig.cmake @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/TivaWareConfig.cmake"
  DESTINATION ${INSTALL_ROOT})


