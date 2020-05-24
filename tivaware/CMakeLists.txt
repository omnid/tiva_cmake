# CMake Build for tivaware driverlib
cmake_minimum_required(VERSION 3.9)
project(driverlib)
include(GNUInstallDirs)

# Usually it is bad practice to glob, but here the files we need are designed
# to be donloaded from within code composer studio and copied and there is
# more danger in missing a new file that is added whenever driverlib is updated
file(GLOB DRIVERLIB_SOURCE driverlib/*.c)

add_library(driverlib ${DRIVERLIB_SOURCE})
target_include_directories(driverlib PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_DATADIR}/tivaware>)


# All install directories are in share since the files are not for the host platform
install(TARGETS driverlib
  EXPORT DriverLibTargets
  LIBRARY DESTINATION ${CMAKE_INSTALL_DATADIR}/tivaware/${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_DATADIR}/tivaware/${CMAKE_INSTALL_LIBDIR}
  )

install(DIRECTORY inc
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tivaware)

install(EXPORT DriverLibTargets
  FILE DriverLibTargets.cmake
  NAMESPACE TivaWare::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tivaware
  )
  
export(EXPORT DriverLibTargets NAMESPACE TivaWare:: FILE driverlib.cmake)
