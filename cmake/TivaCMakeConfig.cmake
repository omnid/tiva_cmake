# Distributed under the LICENSE found in tiva-cmake/LICENSE
#[========================================================================[.rst:
TivaCMakeConfig
----------------------

Specifies the installation location of the TivaCMake installation

Result Variables
^^^^^^^^^^^^^^^^

``TivaCMake_FOUND``
  True if the system has ti-cgt-arm installed
  The root directory of the arm-none-eabi-gcc compiler

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``TivaCMake_ROOT_DIR``
  The root directory of TivaCMake
#]========================================================================]

# The assumption is that if you are running this file is in the final installation location of TivaCMake
set(TivaCMake_FOUND TRUE)

get_filename_component(TivaCMake_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR}/.. ABSOLUTE CACHE) 
