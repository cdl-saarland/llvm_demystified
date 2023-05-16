cmake_minimum_required(VERSION 3.4.3)

project(AdvisorPlugin)
find_package(LLVM REQUIRED CONFIG)
include(AddLLVM)

include_directories(${LLVM_INCLUDE_DIRS})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})

add_llvm_pass_plugin(AdvisorPlugin
  AdvisorPass.cpp
  DEPENDS
  intrinsics_gen
)
