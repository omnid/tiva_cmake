cmake_minimum_required(VERSION 3.12)
project(StartupTest)

find_package(TivaCMake)

# The startup code is linked automatically
add_executable(startup_test startup_test.c)


