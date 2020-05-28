# CMake Build for tivaware driverlib
cmake_minimum_required(VERSION 3.9)
project(TivaWare)
include(GNUInstallDirs)

# Usually it is bad practice to glob, but here the files we need are designed
# to be donloaded from within code composer studio and copied and there is
# more danger in missing a new file that is added whenever driverlib is updated
file(GLOB DRIVERLIB_SOURCE driverlib/*.c)

add_library(driverlib ${DRIVERLIB_SOURCE})
target_include_directories(driverlib PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware>)


# All install directories are in share since the files are not for the host platform
install(TARGETS driverlib
  EXPORT TivaWareTargets 
  LIBRARY DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware/${CMAKE_BUILD_TYPE}/${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware/${CMAKE_BUILD_TYPE}/${CMAKE_INSTALL_LIBDIR}
  )

install(DIRECTORY inc
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware)

# The TivaWareConfig.cmake file imports these targets and makes some generation-time adjustments
# for projects that import this library
install(EXPORT TivaWareTargets
  FILE TivaWareTargets.cmake
  NAMESPACE TivaWare::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware
  )

# This export file can be included from other projects without installing this project
export(EXPORT TivaWareTargets NAMESPACE TivaWare:: FILE TivaWare.cmake)
