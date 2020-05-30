cmake_minimum_required(VERSION 3.9)
project(startup)

add_library(startup_${CMAKE_SYSTEM_PROCESSOR} "${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_C_COMPILER_ID}.c")

# Disable a warning about link time optimization when using the TI compiler
set_source_files_properties(
  "${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_C_COMPILER_ID}" $<$<C_COMPILER_ID:TI>:-pds=1463>>)

# Include the linker script
target_link_libraries(startup PUBLIC
    $<$<C_COMPILER_ID:TI>:${CMAKE_SYSTEM_PROCESSOR}.cmd>
    $<$<C_COMPILER_ID:GNU>:-lm -Wl,-T${CMAKE_SYSTEM_PROCESSOR}.lds>
    >)

include(GNUInstallDirs)

# All install directories are in share since the files are not for the host platform
install(TARGETS startup
  EXPORT TivaCMakeTargets
  LIBRARY DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/lib/${CMAKE_BUILD_TYPE}/${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/lib/${CMAKE_BUILD_TYPE}/${CMAKE_INSTALL_LIBDIR}
  )

# Export the targets directly into a TivaCMakeConfig file since we have no other configuration or dependencies
install(EXPORT TivaCMakeTargets
  FILE TivaCMakeConfig.cmake
  NAMESPACE TivaCMake::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake
  )

# This export file can be included from other projects without installing this project
export(EXPORT TivaCMakeTargets NAMESPACE TivaCMake:: FILE TivaCMake.cmake)
