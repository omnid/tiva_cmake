cmake_minimum_required(VERSION 3.12)
project(LedExample)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "In-source builds are not allowed.")
endif()

# Make TivaCMake's features available to this file
find_package(TivaCMake)

add_executable(led_example main.c)

# EDIT below if you use any other libraries or changed the name of the executable
# Link against the startup code and driverlib
target_link_libraries(led_example TivaCMake::driverlib)

