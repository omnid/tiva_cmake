cmake_minimum_required(VERSION 3.9)
project(startup)

add_library(startup "${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_C_COMPILER_ID}.c")

# Disable a warning about link time optimization when using the TI compiler
set_source_files_properties(
  "${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_C_COMPILER_ID}" $<$<C_COMPILER_ID:TI>:-pds=1463>>)

# Include the linker script
target_link_libraries(startup PUBLIC
    $<$<C_COMPILER_ID:TI>:${CMAKE_SYSTEM_PROCESSOR}.cmd>
    $<$<C_COMPILER_ID:GNU>:-lm -Wl,-T${CMAKE_SYSTEM_PROCESSOR}.lds>
    >)
