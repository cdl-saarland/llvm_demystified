cmake_minimum_required(VERSION 3.4.3)

project(EmulateMulDivPlugin)
find_package(LLVM REQUIRED)
include(AddLLVM)

# The plugin expects to not link against the Support and Core libraries,
# but expects them to exist in the process loading the plugin. This doesn't
# work with DLLs on Windows (where a shared library can't have undefined
# references), so just skip this example on Windows.
if (NOT WIN32)
  add_llvm_pass_plugin(EmulateMulDivPlugin
    EmulateMulDivPass.cpp
    DEPENDS
    intrinsics_gen
   )

   target_include_directories(EmulateMulDivPlugin PUBLIC ${LLVM_INCLUDE_DIR})
   target_link_libraries(EmulateMulDivPlugin PUBLIC LLVM)

  install(TARGETS ${name} RUNTIME DESTINATION "${LLVM_EXAMPLES_INSTALL_DIR}")

  add_subdirectory(solution)
endif()
