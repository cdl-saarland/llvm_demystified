
add_llvm_pass_plugin(EmulateMulDivPluginSolution
EmulateMulDivPassSolution.cpp
DEPENDS
intrinsics_gen
)

target_include_directories(EmulateMulDivPluginSolution PUBLIC ${LLVM_INCLUDE_DIR})
target_link_libraries(EmulateMulDivPluginSolution PUBLIC LLVM)

install(TARGETS ${name} RUNTIME DESTINATION "${LLVM_EXAMPLES_INSTALL_DIR}")
