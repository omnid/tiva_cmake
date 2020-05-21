# see https://cmake.org/Wiki/CMake_Cross_Compiling for ordering of how platform
# files are sourced
# for arm-none-eabi targets, they don't support shared libraries
set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS FALSE)

#  this is the revision number of the silicon for use with
# The Tivaware functions that are stored in ROM
# Markings on the chip indicate the part revision and a table
# in the datasheet translates this to the die (silicon) revision
set(TI_PROCESSOR_TARGET "TM4C123_RB2") # "Revision number for Tivaware")

set(TI_CGT_STACK_SIZE 4096) #"Size of stack, in bytes")

set(TI_CGT_HEAP_SIZE 0) # "Size of heap, in bytes")
