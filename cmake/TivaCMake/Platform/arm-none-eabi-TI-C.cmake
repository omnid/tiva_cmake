# Provide some general-purpose release build flags for the TI-CGT compiler since the build in compiler file for TI-C does not set any optimization flags
# Note: these settings were chosen without much investigation.  The TI-CGT compiler manual has a lot of detail about what the optimization does
# and combinations of what flags to use so you may wish to adjust these or add a custom build type
string(CONCAT
  CMAKE_C_FLAGS_DEBUG_INIT
  "--opt_level=off "         # no optimizations
  "-g "                      # debugging symbols
  )
set(CMAKE_CXX_FLAGS_DEBUG_INIT ${CMAKE_C_FLAGS_DEBUG_INIT})

string(CONCAT
  CMAKE_C_FLAGS_RELEASE_INIT
  "--opt_level=4 " # full optimizations
  "--define=NDEBUG "
  )
set(CMAKE_CXX_FLAGS_RELEASE_INIT ${CMAKE_C_FLAGS_RELEASE_INIT})

string(CONCAT
  CMAKE_C_FLAGS_RELWITHDEBINFO_INIT
  "-g "
  "--opt_level=2 " 
  "--define=NDEBUG "
  )
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT ${CMAKE_C_FLAGS_RELWITHDEBINFO_INIT})

string(CONCAT
  CMAKE_C_FLAGS_MINSIZEREL_INIT
  "--opt_level=4 " 
  "--opt_for_speed=1 " 
  "--define=NDEBUG "
  )
set(CMAKE_CXX_FLAGS_MINSIZEREL_INIT ${CMAKE_C_FLAGS_MINSIZEREL_INIT})
