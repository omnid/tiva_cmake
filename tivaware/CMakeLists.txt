cmake_minimum_required(VERSION 3.12)
project(TivaWare)

include(GNUInstallDirs)

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
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}>)


install(TARGETS driverlib
  EXPORT TivaWareTargets
  LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
  ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}")

# install the include files.
install(DIRECTORY inc driverlib
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  FILES_MATCHING PATTERN "*.h"
  )

# We put this in an internal namespace because when it is actually imported by projects we need to
# add some macro definitions based on information only available at the individual project level.
# See ../toolchain/TivaWare/TivaWareConfig.cmake for details
install(EXPORT TivaWareTargets
  NAMESPACE TivaWare_internal::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/TivaWare)
