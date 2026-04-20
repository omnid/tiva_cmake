find_package(TivaToolchain QUIET)
if(TivaToolchain_DIR)
  include(${TivaToolchain_DIR}/arm-none-eabi-gcc-toolchain.cmake)
endif()
