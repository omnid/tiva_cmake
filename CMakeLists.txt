# Ensure that dependencies are up to date and then build the src directory
cmake_minimum_required(VERSION 3.12)
project(tiva_cmake
  VERSION 0.2.0
  DESCRIPTION "CMake Files for working with Tiva microcontrollers"
  HOMEPAGE_URL "https://github.com/omnid/tiva_cmake"
  LANGUAGES NONE)

# Determine whether to build this for the GNU and TI compilers
option(BUILD_GNU "Build GNU (arm-none-eabi-gcc) support" ON)
option(BUILD_TI "Build TI (ti-cgt-arm) support" OFF)


include(ExternalProject)

#----------- Install the CMake Files for the Toolchain ----------------#
#     All other cross-compilation depends on these cmake files
ExternalProject_Add(
  tiva_toolchain
  PREFIX prefix
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/toolchain
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>)

#----------- Startup Libraries ----------------------------------------#
# Build tivaware libraries (tivaware and the startup code) with different compiler combinations
#   compiler_id - ID of the compiler, (GCC or TI)
#   build_type - the CMakeBuildtype to use (Debug or Release)
function(startup_libraries compiler_id build_type)
  ExternalProject_Add(${compiler_id}_${build_type}_startup
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/startup
    PREFIX prefix
    CMAKE_ARGS
    -DCMAKE_PREFIX_PATH=<INSTALL_DIR>
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${build_type}
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_SOURCE_DIR}/startup/cmake/${compiler_id}-toolchain.cmake)
endfunction()


# Create all the supported varieties of startup library
if(BUILD_GNU)
  startup_libraries(GNU Debug)
  startup_libraries(GNU Release)
elseif(BUILD_TI)
endif()
#    startup_libraries(TI ti-cgt-arm-toolchain.cmake Debug ${proc})



#1 add_subdirectory(lib)

# Building lib installs a bunch of external projects to a single directory
# In the prefix ${CMAKE_BINARY_DIR}/install
# We now want to install that into this project's install prefix
#1 install(DIRECTORY ${CMAKE_BINARY_DIR}/install/share
#1  DESTINATION ".")

#1 install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/src
#1  DESTINATION share/TivaCMake
#1  PATTERN build EXCLUDE
#1  )



#1 include(CTest)
#1 add_test(NAME null_test COMMAND echo "TODO: No unit tests exist for tiva_cmake")
