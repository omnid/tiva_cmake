# This file is run when find_package(TivaWare) is called
# It is used to import targets for TivaWare and then adjust
# some compile options based on the user's configuration
# See [1] for information about the C #defines that are added by this file
include("${CMAKE_CURRENT_LIST_DIR}/TivaWareTargets.cmake")

target_compile_definitions(driverlib INTERFACE PART_${CMAKE_SYSTEM_PROCESSOR})

# You need to set the Silicon Revision for the actual part you are using in order to
# properly call ROM functions. This defaults to the latest Die Revision revision as of 05/20/2020
# Silicon revision can be determined based off of markings on the chip or from registers:
# See [1] for a list of revisions for TM4C123 chips
# See [2] for a list of revisions for TM4C129 chips

set(TM4C123_REVISION "B2" CACHE "Silicon Die Revision for TM4C123 microcontrollers")
set(TM4C129_REVISION "A2" CACHE "Silicon Die Revision for TM4C129 microcontrollers")

if(CMAKE_SYSTEM_PROCESSOR MATCHES "TM4C123")
  target_compile_definitions(driverlib INTERFACE TARGET_IS_TM4C123_${TM4C123_REVISION})
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "TM4C129")
  target_compile_definitions(driverlib INTERFACE TARGET_IS_TM4C129_${TM4C129_REVISION})
else()
    message(WARNING "TivaWare does not support ${CMAKE_SYSTEM_PROCESSOR}, use at your own risk!")
endif()

#[[======================== Works Cited ======================================================
[1] "TivaWare Peripheral Driver Library: User's Guide", Literature Number SPMU298E
     https://www.ti.com/lit/pdf/spmu298 (Accessed on 05/20/2020)
[2] "Tiva C Series TM4C123x Microcontrollers Silicon Revisions 6 and 7 Silicon Errata", Literature Number SPMZ849F
     https://www.ti.com/lit/pdf/spmz849 (Accessed on 05/20/2020)
[3] "Tiva C Series TM4C129x Microcontrollers Silicon Revisions 1, 2, and 3 Silicon Errata", Literature Number SPMZ850G
     https://www.ti.com/lit/pdf/spmz850 (Accessed on 05/20/2020)
#]]=========================================================================================
