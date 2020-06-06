# CMake Build for tivaware driverlib
cmake_minimum_required(VERSION 3.9)
project(TivaWare)

include(GNUInstallDirs)
# root installation directory
set(INSTALL_ROOT ${CMAKE_INSTALL_DATADIR}/TivaWare)

# Usually it is bad practice to glob, but here the files we need are designed
# to be donloaded from within code composer studio and copied and there is
# more danger in missing a new file that is added whenever driverlib is updated
file(GLOB DRIVERLIB_SOURCE driverlib/*.c)

add_library(driverlib ${DRIVERLIB_SOURCE})
target_compile_definitions(driverlib PUBLIC
  $<$<C_COMPILER_ID:TI>:ccs>
  $<$<C_COMPILER_ID:GNU>:gcc>
  )
# Disable a warning about converting packed members
set_source_files_properties(
  "driverlib/emac.c" PROPERTIES COMPILE_FLAGS $<$<C_COMPILER_ID:GNU>:-Wno-address-of-packed-member>)


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

# install the include files.  
install(DIRECTORY inc driverlib
  DESTINATION ${INSTALL_ROOT}
  FILES_MATCHING PATTERN "*.h"
  )

install(EXPORT TivaWareTargets_Debug
  NAMESPACE TivaWare_internal::
  CONFIGURATIONS Debug
  DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}
  )

install(EXPORT TivaWareTargets_Release
  NAMESPACE TivaWare_internal::
  CONFIGURATIONS Release
  DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}
  )

# The TivaWareConfig.cmake file imports the targets based on the value of DRIVERLIB_DEBUG and what
# compiler is being used
install(FILES "${CMAKE_CURRENT_LIST_DIR}/TivaWareConfig.cmake"
  DESTINATION ${INSTALL_ROOT}/cmake)


