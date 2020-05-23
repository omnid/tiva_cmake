# CMake Build for tivaware driverlib
cmake_minimum_required(VERSION 3.9)
project(driverlib)

# Usually it is bad practice to glob, but here the files we need are designed
# to be donloaded from within code composer studio and copied and there is
# more danger in missing a new file that is added whenever driverlib is updated
file(GLOB DRIVERLIB_SOURCE driverlib/*.c)

add_library(driverlib ${DRIVERLIB_SOURCE})
target_include_directories(driverlib PUBLIC .)
