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

``CMAKE_MODULE_PATH``
  This is updated so that TivaCMake modules can be discovered   
Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``TivaCMake_DIR``
The root directory of TivaCMake

Components
^^^^^^^^^^
``None``
  Do not load any components.  This is useful for detecting if tiva-cmake exists from a host system,
  since actually loading the file is only useful when cross-compiling. 

#]========================================================================]

if(NOT TivaCMake_FOUND)
  list(FIND TivaCMake_FIND_COMPONENTS None is_none)
  if(NOT is_none EQUAL -1)
    return()
  endif()

  # The cmake modules that come with tiva-cmake are in the current directory
  # (Note that TivaCMake_DIR is set to be this file by find_package)
  list(APPEND CMAKE_MODULE_PATH ${TivaCMake_DIR})

  # Brings in the TivaCMake::startup and TivaWare::driverlib libraries
  # Enables cmake targets for writing code to the microcontroller and debugging
  # If we are not cross-compiling 
  find_package(TivaStartup)
  find_package(TivaWare)
  
  find_package(OpenOCD QUIET)
  find_package(CodeComposerStudio QUIET)
  find_package(ArmNoneEabiGdb QUIET)

  set(TIVACMAKE_USE_CUSTOM_STARTUP False CACHE BOOL "Stop add_executable from automatically including the TivaCMake::startup startup code.")

  # adds a uniflash target that uses uniflash to write to the tiva
  # ext is the name of the extension to add to the target (so ${target}.${ext} is how to invoke this step)
  function(add_uniflash target_name ext)
    # TODO: choose ccxml file based on CMAKE_SYSTEM_PROCESSOR.
    # currently these are the same name
    add_custom_target(${target_name}.${ext}
      DEPENDS ${target_name}
      COMMAND ${CodeComposerStudio_UniFlash_EXECUTABLE} -ccxml "${TivaStartup_DIR}/../${CMAKE_SYSTEM_PROCESSOR}.ccxml"
      -program "$<TARGET_FILE:${target_name}>"
      -verify "$<TARGET_FILE:${target_name}>"
      COMMENT "Using uniflash to load ${target_name} onto the microcontroller."
      VERBATIM
      )
  endfunction()
  
  # adds a target that will write to the tiva using openocd.
  # ext is the name of the extension to add to the target (so ${target}.${ext} is how to invoke this step)
  function(add_openocd_write target_name ext)
    add_custom_target(${target_name}.${ext}
      DEPENDS ${target_name}
      COMMAND ${OpenOCD_EXECUTABLE} -f ${OpenOCD_CONFIG} -c "program $<TARGET_FILE:${target_name}> verify reset exit"
      COMMENT "Using openocd to load ${target_name} onto the microcontroller."
      VERBATIM
      )
  endfunction()

  # adds a makefile target that will write to the tiva using openocd
  # and attach the gcc debugger
  function(add_openocd_gdb target_name)
    # that variable is set in FindArmNoneEabiGcc and FIndTiCgt
    add_custom_target(${target_name}.gdb
      COMMAND ${ArmNoneEabiGdb_EXECUTABLE} 
      -ex "dir $cdir:$cwd:${TiCgtArm_SOURCE_DIRS}"
      -ex "target extended-remote | ${OpenOCD_EXECUTABLE} -f ${OpenOCD_CONFIG} -c \"gdb_port pipe; log_output ${CMAKE_BINARY_DIR}/openocd.log\"" 
      -ex "monitor reset halt" 
      -ex "load" 
      "$<TARGET_FILE:${target_name}>"
      DEPENDS ${target_name}
      COMMENT "Using openocd and arm-none-eabi-gdb to debug ${target_name} on the microcontroller."
      VERBATIM
      )
  endfunction()

  # attaches gdb to the running target, and assumes that the
  # target is running the desired binary file
  function(add_openocd_attach target_name)
    add_custom_target(${target_name}.attach
      COMMAND ${ArmNoneEabiGdb_EXECUTABLE} "$<TARGET_FILE:${target_name}>"
      -ex "dir $cdir:$cwd:${TiCgtArm_SOURCE_DIRS}"
      -ex "target extended-remote | ${OpenOCD_EXECUTABLE} -f ${OpenOCD_CONFIG} -c \"gdb_port pipe; log_output ${CMAKE_BINARY_DIR}/openocd.log\"" 
      -ex "monitor halt"
      DEPENDS ${target_name}
      COMMENT "Using openocd and arm-none-eabi-gdb to debug ${target_name} while it is already running."
      VERBATIM
      )
  endfunction()

  
  # combine all the extra custom build steps
  function(tiva_cmake_add target)
    add_uniflash(${target} uni)
    add_openocd_write(${target} ocd)
    add_openocd_gdb(${target})
    add_openocd_attach(${target})
    if(OpenOCD_FOUND)
      add_openocd_write(${target} write)
    else()
      add_uniflash(${target} write)
    endif()

    # also convert to a bin file
    add_custom_command(TARGET ${target} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -I elf32-little  -O binary "${target}" "${target}.bin"
    COMMENT "Creating binfile ${target}.bin"
    BYPRODUCTS "${target}.bin"
    VERBATIM
    )
  #add the executable to the be cleaned by make clean
  set_property(DIRECTORY APPEND
    PROPERTY ADDITIONAL_MAKE_CLEAN_FILES
    ${target}.bin
    )
  endfunction()

  set(TivaCMake_AddExecutable ON CACHE BOOL "Include extra tiva_cmake targets when calling add_executable")
  mark_as_advanced(TivaCMake_AddExecutable)

  if(TivaCMake_AddExecutable)
    # Override add_executable to add these other targets
    function(add_executable target)
      # call the original
      _add_executable(${target} ${ARGN})
      if(NOT TIVACMAKE_USE_CUSTOM_STARTUP)
        target_link_libraries(${target} TivaCMake::startup)
      endif()
      tiva_cmake_add(${target})
    endfunction()
  endif()
endif()
