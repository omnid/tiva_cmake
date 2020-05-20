# Distributed under the LICENSE found in tiva-cmake/LICENSE
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

#]========================================================================]
# A guide for writing find modules: https://cmake.org/cmake/help/v3.17/manual/cmake-developer.7.html
if(NOT CodeComposerStudio_FOUND)
  # Gather directory names to search
  file(GLOB CodeComposerStudio_ROOTS
    $ENV{HOME}/ti/ccs* $ENV{HOME}/ccs* /opt/ccs* /opt/ti/ccs*)

  # Find the code composer studio executable
  find_program(CodeComposerStudio_EXECUTABLE
    NAMES ccstudio
    HINTS ${CodeComposerStudio_ROOTS}
    PATH_SUFFIXES ccs/eclipse
    NO_DEFAULT_PATH
    )

  # Get the root directory
  get_filename_component(CodeComposerStudio_EXEPATH ${CodeComposerStudio_EXECUTABLE} DIRECTORY)
  get_filename_component(CodeComposerStudio_ROOT_DIR ${CodeComposerStudio_EXEPATH}/../.. ABSOLUTE)
  # We want ROOT_DIR to be in the cache and also be of type PATH
  set(CodeComposerStudio_ROOT_DIR ${CodeComposerStudio_ROOT_DIR} CACHE PATH "Base Directory for Code Composer Studio")

  # It should have left an install log with the version
  # Code Composer Studio maintains a folder with the version number
  find_path(CodeComposerStudio_ARTIFACT
    NAMES artifacts.xml
    HINTS ${CodeComposerStudio_ROOT_DIR}/ccs/install_info/*
    )
  get_filename_component(CodeComposerStudio_VERSION ${CodeComposerStudio_ARTIFACT} NAME )
  unset(CodeComposerStudio_ARTIFACT CACHE)

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(CodeComposerStudio
    FOUND_VAR CodeComposerStudio_FOUND
    REQUIRED_VARS
    CodeComposerStudio_EXECUTABLE
    CodeComposerStudio_ROOT_DIR
    VERSION_VAR CodeComposerStudio_VERSION
    )
endif()
