# Basic template for using tiva-cmake
# Edit this file to add your own executables and c files.
# Lines to modify are marked with Edit:
cmake_minimum_required(VERSION 3.9)
# EDIT to change the name of the cmake project (not overly important)
project(LedExample)

include(TivaCMake)

# EDIT: to change the name of the executable and what source files compose it
add_executable(led_example main.c)

# EDIT: if you use any other libraries or changed the name of the executable
# Link against the startup code and driverlib
target_link_libraries(led_example TivaCMake::startup TivaCMake::driverlib)

