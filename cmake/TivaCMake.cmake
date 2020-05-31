# Brings in the TivaCMake::startup and TivaWare::driverlib libraries
# Enables cmake targets for writing code to the microcontroller and debugging
# If we are not cross-compiling 
if((NOT TivaCMake_FOUND) AND (CMAKE_CROSS_COMPILING)) 
  set(TivaCMake_FOUND TRUE)
  find_package(TivaStartup)
  find_package(TivaWare)
  find_package(OpenOCD)
  find_package(CodeComposerStudio)
  find_package(ArmNoneEabiGdb)

  # adds a target that will write to the tiva using openocd
  function(add_openocd_write target_name)
    add_custom_target(${target_name}.ocd
      DEPENDS ${target_name}
      COMMAND ${OPENOCD} -f ${OPENOCD_CONFIG} -c "program $<TARGET_FILE:${target_name}> verify reset exit"
      COMMENT "Using openocd to load ${target_name} onto the microcontroller."
      )
  endfunction()

  # adds a makefile target that will write to the tiva using openocd
  # and attach the gcc debugger
  function(add_openocd_gdb target_name)
    if(TIVA_CLIB_SRC_PATH)
      set(TIVA_CLIB_DIR_CMD "-ex dir ${TIVA_CLIB_SRC_PATH}")
    endif()
    # the dir ${TIVA_CLIB_SRC_PATH} puts the c standard library source code on gdb's path
    # that variable is set in FindArmNoneEabiGcc and FIndTiCgt
    add_custom_target(${target_name}.gdb
      COMMAND ${ARMGDB} ${TIVA_CLIB_DIR_CMD}
      -ex "target extended-remote | ${OPENOCD} -f ${OPENOCD_CONFIG} -c \"gdb_port pipe; log_output ${CMAKE_BINARY_DIR}/openocd.log\"" 
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
    if(TIVA_CLIB_SRC_PATH)
      set(TIVA_CLIB_DIR_CMD "-ex dir ${TIVA_CLIB_SRC_PATH}")
    endif()
    add_custom_target(${target_name}.attach
      COMMAND ${ARMGDB} "$<TARGET_FILE:${target_name}>" 
      ${TIVA_CLIB_DIR_CMD}
      -ex "target extended-remote | ${OPENOCD} -f ${OPENOCD_CONFIG} -c \"gdb_port pipe; log_output ${CMAKE_BINARY_DIR}/openocd.log\"" 
      -ex "monitor halt"
      DEPENDS ${target_name}
      COMMENT "Using openocd and arm-none-eabi-gdb to debug ${target_name} while it is already running."
      VERBATIM
      )
  endfunction()

endif()

