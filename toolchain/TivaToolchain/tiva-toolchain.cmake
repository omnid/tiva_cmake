# Toolchain file that will use gcc if it is available and if not will switch to ti-cgt

# remove the path from the list at the end of this file
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../TivaCMake)

find_package(TiCgtArm QUIET)
find_package(ArmNoneEabiGCC QUIET)

if(ArmNoneEabiGCC_FOUND)
  include(${CMAKE_CURRENT_LIST_DIR}/arm-none-eabi-gcc-toolchain.cmake)
elseif(TiCgtArm_FOUND)
  include(${CMAKE_CURRENT_LIST_DIR}/ti-cgt-arm-toolchain.cmake)
else()
  message(FATAL_ERROR "Could not find the GNU or TI toolchain")
endif()

