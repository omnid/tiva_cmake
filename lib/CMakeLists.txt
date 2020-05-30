cmake_minimum_required(VERSION 3.9)
project(startup)

add_library(startup "${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_C_COMPILER_ID}.c")

# Disable a warning about link time optimization when using the TI compiler
set_source_files_properties(
  "${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_C_COMPILER_ID}.c" $<$<C_COMPILER_ID:TI>:-pds=1463>>)

# Include the linker script
target_link_libraries(startup PUBLIC
    $<$<C_COMPILER_ID:TI>:${CMAKE_SYSTEM_PROCESSOR}.cmd>
    $<$<C_COMPILER_ID:GNU>:-lm -Wl,-T${CMAKE_SYSTEM_PROCESSOR}.lds>
    >)

include(GNUInstallDirs)

# All install directories are in share since the files are not for the host platform
# We split into commands for Debug and Release versions to be compatible with multi-configuration generators
install(TARGETS startup
  EXPORT TivaCMakeTargets_Debug
  CONFIGURATIONS Debug
  LIBRARY DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/lib/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/lib/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )

install(TARGETS startup
  EXPORT TivaCMakeTargets_Release
  CONFIGURATIONS Release
  LIBRARY DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/lib/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/lib/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )

# Export the targets directly into a TivaCMakeConfig file since we have no other configuration or dependencies
install(EXPORT TivaCMakeTargets_Debug
  CONFIGURATIONS Debug
  NAMESPACE TivaCMake::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/lib/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )

install(EXPORT TivaCMakeTargets_Release
  CONFIGURATIONS Release
  NAMESPACE TivaCMake::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/lib/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )

