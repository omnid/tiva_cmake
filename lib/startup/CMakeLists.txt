cmake_minimum_required(VERSION 3.9)
project(startup)

include(GNUInstallDirs)

# root installation directory
set(INSTALL_ROOT ${CMAKE_INSTALL_DATADIR}/TivaStartup)

# The library is a series of object files.
# We make these as OBJECT files instead of a library (ar archive)
# To ensure that everything in them gets linked in to the main program
# even if its not called.
# Another option would be to use the --whole-archive linker object for GNU compilers.
# TI compilers seem to link everything from the archive anyway, but I don't know if that's well-defined behavior
# or if we just get lucky, so the collection of OBJECT files seems to work better. From a user perspective it makes little difference
add_library(startup
  OBJECT
  ${CMAKE_SYSTEM_PROCESSOR}_isr.c
  reset.c
  $<$<C_COMPILER_ID:GNU>:startup.c>
  )

# For gcc we need to ensure that the whole startup archive (i.e., all object files in startup) get linked in even
# if they are not referenced


# Disable a warning about link time optimization when using the TI compiler
set_source_files_properties(
  "${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_C_COMPILER_ID}.c" $<$<C_COMPILER_ID:TI>,-pds=1463>>)

# Include the linker script
target_link_libraries(startup PUBLIC
    $<$<C_COMPILER_ID:TI>:${CMAKE_SYSTEM_PROCESSOR}.cmd>
    $<$<C_COMPILER_ID:GNU>:-lm -Wl,-T${CMAKE_SYSTEM_PROCESSOR}.lds>
    )
target_link_directories(startup PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:${INSTALL_ROOT}>)


# All install directories are in share since the files are not for the host platform
# We split into commands for Debug and Release versions to be compatible with multi-configuration generators
install(TARGETS startup
  EXPORT TivaStartupTargets_Debug
  CONFIGURATIONS Debug
  LIBRARY DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  ARCHIVE DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  OBJECTS DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )

install(TARGETS startup
  EXPORT TivaStartupTargets_Release
  CONFIGURATIONS Release
  LIBRARY DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  ARCHIVE DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  OBJECTS DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )

# Export the targets directly into a TivaStartupConfig file since we have no other configuration or dependencies
install(EXPORT TivaStartupTargets_Debug
  CONFIGURATIONS Debug
  NAMESPACE TivaStartup::
  DESTINATION ${INSTALL_ROOT}/Debug_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )

install(EXPORT TivaStartupTargets_Release
  CONFIGURATIONS Release
  NAMESPACE TivaCMake::
  DESTINATION ${INSTALL_ROOT}/Release_${CMAKE_C_COMPILER_ID}_${CMAKE_SYSTEM_PROCESSOR}
  )


# The TivaStartupConfig file imports the targets based on the value of STARTUPLIB_DEBUG and what
# compiler is being used
install(FILES "${CMAKE_CURRENT_LIST_DIR}/TivaStartupConfig.cmake"
  DESTINATION ${INSTALL_ROOT}/cmake)

install(FILES
  "${CMAKE_CURRENT_LIST_DIR}/${CMAKE_SYSTEM_PROCESSOR}.cmd"
  "${CMAKE_CURRENT_LIST_DIR}/${CMAKE_SYSTEM_PROCESSOR}.lds"
  "${CMAKE_CURRENT_LIST_DIR}/${CMAKE_SYSTEM_PROCESSOR}.ccxml"
  DESTINATION ${INSTALL_ROOT}
  )
