# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appProcessBar_Simple_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appProcessBar_Simple_autogen.dir\\ParseCache.txt"
  "appProcessBar_Simple_autogen"
  )
endif()
