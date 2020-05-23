# in the future these values may be set in the processor-specific platform file
# arm-none-eabi-GNU-C-${CMAKE_SYSTEM_PROCESSOR}.cmake
set(ARM_FPU "fpv4-sp-d16") # hardware fpu version
set(PROCESSOR_MCPU cortex-m4) # CACHE STRING "The value for the -mcpu flag")
set(PROCESSOR_MARCH armv7e-m) # CACHE STRING "The -march option")

# Concatenate the options so I can comment each one on its own line.  Put a space after each option
# This sets the default compiler options when using arm-none-eabi-gcc.
# These are the options in CMAKE_C_FLAGS, for example
string(CONCAT
  CMAKE_C_FLAGS_INIT # These are flags set for all builds with ti-cgt-arm
  "-mthumb "         # use thumb mode code
  "-mcpu=${PROCESSOR_MCPU} "
  "-march=${PROCESSOR_MARCH} "
  "-mfloat-abi=hard " # hardware floating point with software calling conventions
  "-mfpu=${ARM_FPU} " # floating point to use
  "-ffunction-sections " # seperate function sections
  "-fdata-sections " # separate data sections
  "-DPART_${CMAKE_SYSTEM_PROCESSOR} " # The processor model for the exact part
  "-DTARGET_IS_${TI_PROCESSOR_TARGET} " # The exact silicon revision for the tivaware functions in ROM. see the tivaware ROM docs for the appropriate flag
  "-gdwarf-3 "
  "-gstrict-dwarf "
  )

string(CONCAT
  CMAKE_C_FLAGS_DEBUG_INIT
  "-g " # debugging symbols
  "-Og " # some optimizations that don't effect debugging
  )


string(CONCAT
  CMAKE_C_FLAGS_RELEASE_INIT
  "-O3 " # full optimizations
  "-DNDEBUG "
  )
string(CONCAT # concatenate the options for the linker
  CMAKE_EXE_LINKER_FLAGS_INIT # Initial linker flags for all configuration
  "--specs=nosys.specs " # no systemcalls 
  )

set(CMAKE_EXECUTABLE_SUFFIX ".elf")
