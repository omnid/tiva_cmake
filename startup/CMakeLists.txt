cmake_minimum_required(VERSION 3.12)
project(TivaStartup)

include(GNUInstallDirs)

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
  $<$<C_COMPILER_ID:GNU>:
      startup.c
      stubs.c>
  )
target_compile_features(startup PRIVATE c_std_99)
target_compile_options(startup PRIVATE
  $<$<C_COMPILER_ID:GNU,CLANG>:-pedantic -pipe -Wall -Wextra -fmacro-prefix-map=${CMAKE_CURRENT_SOURCE_DIR}/=$<TARGET_PROPERTY:NAME>:>
  $<$<C_COMPILER_ID:TI>:-pden -pdr -pdv --diag_suppress=270 --diag_suppress=1463>) # disable warning about link time optimization


# Include the linker script
target_link_libraries(startup PUBLIC
    $<$<C_COMPILER_ID:TI>:${CMAKE_SYSTEM_PROCESSOR}.cmd>
    $<$<C_COMPILER_ID:GNU>:-lm -Wl,-T${CMAKE_SYSTEM_PROCESSOR}.lds>
    )
target_link_directories(startup PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}>)


install(TARGETS startup EXPORT TivaStartupTargets
  LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
  ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
  OBJECTS DESTINATION "${CMAKE_INSTALL_LIBDIR}")

# Export the targets directly into a TivaStartupConfig file.
# We don't have other dependencies so we don't need to add to that config file.
install(EXPORT TivaStartupTargets
  NAMESPACE TivaCMake::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/TivaStartup)

install(FILES
  "${CMAKE_SYSTEM_PROCESSOR}.cmd"
  "${CMAKE_SYSTEM_PROCESSOR}.lds"
  "${CMAKE_SYSTEM_PROCESSOR}.ccxml"
  DESTINATION "${CMAKE_INSTALL_LIBDIR}")
