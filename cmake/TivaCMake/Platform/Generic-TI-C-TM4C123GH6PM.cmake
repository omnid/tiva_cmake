# Setup compile flags for a TM4C123GH6PM
# It is likely that other tiva microcontroller use similar flags, but it is currently the clearest approach to
# write out all the flags for each individual processor in a file named Generic-GNU-C-<Processor>.cmake
# Build a list of flags used for C and C++
# Note: the space in the string after each option is important since this forms the string of options and
# each option should be separated by a space. 

string(CONCAT        
  MCU_FLAGS
  "-mv7M4 "                                   # Processor version
  "--code_state=16 "                          # The code state (16-bit thumb or 32-bit)
  "--float_support=FPv4SPD16 "                # The floating point unit to use
  "--include_path=${TiCgtArm_INCLUDE_DIRS} "  # standard library include path
  "-me "                                      # little endian mode
  )

string(APPEND CMAKE_C_FLAGS_INIT ${MCU_FLAGS})
string(APPEND CMAKE_CXX_FLAGS_INIT ${MCU_FLAGS})
unset(MCU_FLAGS)

string(APPEND 
  CMAKE_EXE_LINKER_FLAGS_INIT   # Initial linker flags for all configuration
  "-z "                         # start linker options
  "-i${TiCgtArm_LIBRARY_DIRS} " # path to the standard library, which library to use is auto-detected
  "--rom_model "                # store the program in flash not ram
  "--stack_size=4096 "          # the stack size, in bytes
  "--heap_size=0 "              # the heap size, in bytes
  "--reread_libs "              # recursively read libraries to resolve some dependencies
  )

