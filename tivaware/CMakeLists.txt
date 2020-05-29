# CMake Build for tivaware driverlib
cmake_minimum_required(VERSION 3.9)
project(TivaWare)
include(GNUInstallDirs)

# Usually it is bad practice to glob, but here the files we need are designed
# to be donloaded from within code composer studio and copied and there is
# more danger in missing a new file that is added whenever driverlib is updated
file(GLOB DRIVERLIB_SOURCE driverlib/*.c)

# We add the buildtype to the library name so we can easily refer to different builds
add_library(driverlib_${CMAKE_BUILD_TYPE} ${DRIVERLIB_SOURCE})

target_include_directories(driverlib_${CMAKE_BUILD_TYPE} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware>)


# All install directories are in share since the files are not for the host platform
# The Targets are also labeled by build type
install(TARGETS driverlib_${CMAKE_BUILD_TYPE}
  EXPORT TivaWareTargets_${CMAKE_BUILD_TYPE}
  LIBRARY DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware/${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware/${CMAKE_INSTALL_LIBDIR}
  )

install(DIRECTORY inc
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware)

install(EXPORT TivaWareTargets_${CMAKE_BUILD_TYPE}
  FILE TivaWareTargets_${CMAKE_BUILD_TYPE}.cmake
  NAMESPACE TivaWare::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware
  )

# The TivaWareConfig.cmake file imports the targets based on the value of DRIVERLIB_DEBUG
install(FILES "${CMAKE_CURRENT_LIST_DIR}/TivaWareConfig.cmake"
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/tivaware)


# This export file can be included from other projects without installing this project
export(EXPORT TivaWareTargets_${CMAKE_BUILD_TYPE} NAMESPACE TivaWare:: FILE TivaWare_${CMAKE_BUILD_TYPE}.cmake)
