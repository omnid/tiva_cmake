# Distributed under the LICENSE found in tiva_cmake/LICENSE
#[========================================================================[.rst:
FindCodeComposerStudio
----------------------

Finds Code Composer Studio.  Looks in the default installation directories,
as determined the Code Composer Studio installer.

On Linux it looks for `/home/$(whoami)/ti/ccsXXXX`, `/home/$(whoami)/ccsXXXX`, `/opt/ti/ccsXXXX`, `/opt/ccsXXXX`.

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``CodeComposerStudio_FOUND``
  True if the system has Code Composer Studio installed.
``CodeComposerStudio_VERSION``
  The version of Code Composer Studio that was found.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``CodeComposerStudio_EXECUTABLE``
  The executable that runs Code Composer Studio

``CodeComposerStudio_ROOT_DIR``
  The root directory of Code Composer Studio. 

``CodeComposerStudio_UniFlash_EXECUTABLE``
  The executable that runs the UniFlash tool, used for flashing microcontrollers
#]========================================================================]
# A guide for writing find modules: https://cmake.org/cmake/help/v3.17/manual/cmake-developer.7.html
if(NOT CodeComposerStudio_FOUND)
  # Gather directory names to search
  file(GLOB CodeComposerStudio_ROOTS
    $ENV{HOME}/ti/ccs* $ENV{HOME}/ccs* /opt/ccs* /opt/ti/ccs* /Applications/ti/ccs* )


  # Find the code composer studio executable
  
  find_path(CodeComposerStudio_ROOT_DIR
	NAMES ccs  
    HINTS ${CodeComposerStudio_ROOTS}
  
  
	)


set(CodeComposerStudio_ROOT_DIR ${CodeComposerStudio_BASE} CACHE PATH "Base Directory for Code Composer Studio")

  # Get the root directory
  
  # on MacOS CodeComposerStudio stories its executable deeper in the directory
#  if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
#	get_filename_component(CodeComposerStudio_EXEPATH ${CodeComposerStudio_EXECUTABLE} DIRECTORY)
#	get_filename_component(CodeComposerStudio_ROOT_DIR ${CodeComposerStudio_EXEPATH}/../../../../.. ABSOLUTE)	
 # else()	
#	get_filename_component(CodeComposerStudio_EXEPATH ${CodeComposerStudio_EXECUTABLE} DIRECTORY)
#	get_filename_component(CodeComposerStudio_ROOT_DIR ${CodeComposerStudio_EXEPATH}/../.. ABSOLUTE)
 # endif()
  # We want ROOT_DIR to be in the cache and also be of type PATH
#  set(CodeComposerStudio_ROOT_DIR ${CodeComposerStudio_ROOT_DIR} CACHE PATH "Base Directory for Code Composer Studio")
  


  # It should have left an install log with the version
  # Code Composer Studio maintains a folder with the version number
  find_path(CodeComposerStudio_ARTIFACT
    NAMES artifacts.xml
    HINTS ${CodeComposerStudio_ROOT_DIR}/ccs/install_info/*
    )


  get_filename_component(CodeComposerStudio_VERSION ${CodeComposerStudio_ARTIFACT} NAME )
  unset(CodeComposerStudio_ARTIFACT CACHE)

  if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
    set(uniflash_name "uniflash.bat")
  else()
    set(uniflash_name "uniflash.sh")
  endif()
  

  
  find_program(CodeComposerStudio_UniFlash_EXECUTABLE
    ${uniflash_name}
    PATHS ${CodeComposerStudio_ROOT_DIR}/ccs/ccs_base/scripting/examples/uniflash/cmdLine
    NO_DEFAULT_PATH)


  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(CodeComposerStudio
    FOUND_VAR CodeComposerStudio_FOUND
    REQUIRED_VARS
    CodeComposerStudio_UniFlash_EXECUTABLE
    CodeComposerStudio_ROOT_DIR
    VERSION_VAR CodeComposerStudio_VERSION
    )
endif()
