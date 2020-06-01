# Brings in the TivaCMake::startup and TivaWare::driverlib libraries
# Enables cmake targets for writing code to the microcontroller and debugging
# If we are not cross-compiling 
if((NOT TivaCMake_FOUND) AND (CMAKE_CROSSCOMPILING)) 
  set(TivaCMake_FOUND TRUE)
  find_package(TivaStartup)
  find_package(TivaWare)
  find_package(OpenOCD)
  find_package(CodeComposerStudio)
  find_package(ArmNoneEabiGdb)
  # adds a uniflash target that uses uniflash to write to the tiva
  function(add_uniflash target_name)
    # TODO: choose ccxml file based on CMAKE_SYSTEM_PROCESSOR.
    # currently these are the same name
    add_custom_target(${target_name}.uni
      DEPENDS ${target_name}
      COMMAND ${CodeComposerStudio_UniFlash_EXECUTABLE} -ccxml "${CMAKE_CURRENT_LIST_DIR}/../startup/${CMAKE_SYSTEM_PROCESSOR}.ccxml"
      -program "$<TARGET_FILE:${target_name}>"
      -verify "$<TARGET_FILE:${target_name}>"
      COMMENT "Using uniflash to load ${target_name} onto the microcontroller."
      VERBATIM
      )
    endfunction()
      
  # adds a target that will write to the tiva using openocd
  function(add_openocd_write target_name)
    add_custom_target(${target_name}.ocd
      DEPENDS ${target_name}
      COMMAND ${OpenOCD_EXECUTABLE} -f ${OpenOCD_CONFIG} -c "program $<TARGET_FILE:${target_name}> verify reset exit"
      COMMENT "Using openocd to load ${target_name} onto the microcontroller."
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
    add_uniflash(${target})
    add_openocd_write(${target})
    add_openocd_gdb(${target})
    add_openocd_attach(${target})
  endfunction()

  set(TivaCMake_AddExecutable ON CACHE BOOL "Include extra tiva_cmake targets when calling add_executable")
  mark_as_advanced(TivaCMake_AddExecutable)

  if(TivaCMake_AddExecutable)
    # Override add_executable to add these other targets
    function(add_executable target)
      # call the original
      _add_executable(${target} ${ARGN})
      tiva_cmake_add(${target})
    endfunction()
  endif()
endif()

