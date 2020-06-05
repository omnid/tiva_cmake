# Distributed under the LICENSE found in tiva-cmake/LICENSE
#[========================================================================[.rst:
FindArmNoneEabiGdb
----------------------

Finds `gdb` for arm processors, searching in the regular system directories

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``ArmNoneEabiGdb_FOUND``
  True if the system has ti-cgt-arm installed

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``ArmNoneEabiGdb_EXECUTABLE``
  The gdb executable for debugging arm processors

#]========================================================================]
# A guide for writing find modules: https://cmake.org/cmake/help/v3.17/manual/cmake-developer.7.html

if(NOT ArmNoneEabiGdb_FOUND)
  
  # Find arm-none-eabi-gdb which is gdb for arm processors
  # It can also find the gdb-multiarch binary which will also work to debug on arm
  file(GLOB ARM_NONE_EABI_ROOTS "/opt/arm-none-eabi-gcc*/bin")

  # reverse the list so the latest version is used first.  Search in regular system paths and opt
  list(REVERSE ARM_NONE_EABI_ROOTS)
  find_program(ArmNoneEabiGdb_EXECUTABLE
    NAMES arm-none-eabi-gdb gdb-multiarch
    HINTS ${ARM_NONE_EABI_ROOTS}
    )

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(ArmNoneEabiGdb
    FOUND_VAR ArmNoneEabiGdb_FOUND
    REQUIRED_VARS
    ArmNoneEabiGdb_EXECUTABLE
  #  VERSION_VAR ArmNoneEabiGCC_VERSION TODO: Version
    )

endif()



