cmake_minimum_required(VERSION 3.9)
project(startup)

include(GNUInstallDirs)

# root installation directory
set(INSTALL_ROOT ${CMAKE_INSTALL_DATADIR}/tiva-cmake/startup)

add_library(startup "${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_C_COMPILER_ID}.c")

# Disable a warning about link time optimization when using the TI compiler
set_source_files_properties(
  "${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_C_COMPILER_ID}.c" $<$<C_COMPILER_ID:TI>:-pds=1463>>)

# Include the linker script
target_link_libraries(startup PUBLIC
    $<$<C_COMPILER_ID:TI>:${CMAKE_SYSTEM_PROCESSOR}.cmd>
    $<$<C_COMPILER_ID:GNU>:-lm -Wl,-T${CMAKE_SYSTEM_PROCESSOR}.lds>
    >)
target_link_directories(startup PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:${INSTALL_ROOT}>)


# All install directories are in share since the files are not for the host platform
# We split into commands for Debug and Release versions to be compatible with multi-configuration generators
install(TARGETS startup
  EXPORT TivaCMakeTargets_Debug
  CONFIGURATIONS Debug
  LIBRARY DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  ARCHIVE DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )

install(TARGETS startup
  EXPORT TivaCMakeTargets_Release
  CONFIGURATIONS Release
  LIBRARY DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  ARCHIVE DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )

# Export the targets directly into a TivaCMakeConfig file since we have no other configuration or dependencies
install(EXPORT TivaCMakeTargets_Debug
  CONFIGURATIONS Debug
  NAMESPACE TivaCMake::
  DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )

install(EXPORT TivaCMakeTargets_Release
  CONFIGURATIONS Release
  NAMESPACE TivaCMake::
  DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )


# The TivaCMakeConfig file imports the targets based on the value of STARTUPLIB_DEBUG and what
# compiler is being used
install(FILES "${CMAKE_CURRENT_LIST_DIR}/TivaCMakeConfig.cmake"
  DESTINATION ${CMAKE_INSTALL_DATADIR}/tiva-cmake/cmake)

install(FILES
  "${CMAKE_CURRENT_LIST_DIR}/${CMAKE_SYSTEM_PROCESSOR}.cmd"
  "${CMAKE_CURRENT_LIST_DIR}/${CMAKE_SYSTEM_PROCESSOR}.lds"
  DESTINATION ${INSTALL_ROOT}
  )
