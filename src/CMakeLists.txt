# Basic template for using tiva-cmake
# Edit this file to add your own executables and c files.
# Lines to modify are marked with Edit:
cmake_minimum_required(VERSION 3.9)
# EDIT below to change the name of the cmake project 
project(LedExample)

# Make TivaCMake's features available to this file 
find_package(TivaCMake)

# EDIT below to change the name of the executable and what source files compose it
add_executable(led_example main.c) 

# EDIT below if you use any other libraries or changed the name of the executable
# Link against the startup code and driverlib
target_link_libraries(led_example TivaCMake::driverlib TivaCMake::startup)

