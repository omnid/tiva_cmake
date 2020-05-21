# floating point version. IN the future these flags might be set
# in the processor-specific arm-none-eabi-TI-C-CMAKE_SYSTEM_PROCESSOR.cmake fiile
set(TI_CGT_ARM_FPU "FPv4SPD16") # I think all the TM4C have the same FPU
set(TI_CGT_ARM_CODE_STATE 16) # all have the 16 bit code state
# some of these flags will need to change if the processor is not a tm4c
set(TI_SILICON_VERSION 7M4) # "The silicon version")

# Set the initial flags for compiling.
string(CONCAT        # Concatenate the options so I can comment each one on its own line.  Put a space after each option
  CMAKE_C_FLAGS_INIT # These are flags set for all builds with ti-cgt-arm
  "-mv${TI_SILICON_VERSION} "          # Processor version
  "--code_state=${TI_CGT_ARM_CODE_STATE} " # The code state (16-bit thumb or 32-bit)
  "--float_support=${TI_CGT_ARM_FPU} "     # The floating point unit to use
  "--include_path=${TI_CGT_ARM_BIN_PATH}/../include " # standard library include path
  "-me "                                   # little endian (should probably verify that processor is little endian)
  "--define=ccs=\"ccs\" " # define ccs since ti code conditions on this some places
  "--define=PART_${CMAKE_SYSTEM_PROCESSOR} " # The processor model for the exact part
  "--define=TARGET_IS_${TI_PROCESSOR_TARGET} " # The exact silicon revision for the tivaware functions in ROM. see the tivaware ROM docs for the appropriate flag
  )

string(CONCAT
  CMAKE_C_FLAGS_DEBUG_INIT
  "--opt_level=off " # no optimizations
  "-g " # debugging symbols
  )


string(CONCAT
  CMAKE_C_FLAGS_RELEASE_INIT
  "--opt_level=4 " # full optimizations
  "--define=NDEBUG "
  )
string(CONCAT # concatenate the options for the linker
  CMAKE_EXE_LINKER_FLAGS_INIT # Initial linker flags for all configuration
  "-z " # start linker options
  "-i${TI_CGT_ARM_BIN_PATH}/../lib " # path to the standard library, which library to use is auto-detected
  "--rom_model " # store the program in flash not ram
  "--stack_size=${TI_CGT_STACK_SIZE} " # the stack size, in bytes
  "--heap_size=${TI_CGT_HEAP_SIZE} " # the heap size, in bytes
  "--reread_libs " # recursively read libraries to resolve some dependencies
  )

# the ti compiler uses windows library naming conventions
set(CMAKE_STATIC_LIBRARY_SUFFIX ".lib")
set(CMAKE_STATIC_LIBRARY_PREFIX "")
set(CMAKE_EXECUTABLE_SUFFIX ".elf")
set(CMAKE_FIND_LIBRARY_PREFIXES "")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib" "lib.lib")

