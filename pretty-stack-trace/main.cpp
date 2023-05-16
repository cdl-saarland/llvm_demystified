#include <iostream>
#include "llvm/ADT/StringRef.h"
#include "llvm/Support/SystemUtils.h"
#include "llvm/Support/Signals.h"
#include "llvm/Support/PrettyStackTrace.h"

__attribute__((noinline))
int* bar1(int* ptr) {
  return (int*)(((intptr_t) ptr / 0));
}

__attribute__((noinline))
int* bar2(int* ptr) {
  return bar1(ptr + 2);
}

__attribute__((noinline)) 
int* foo(void* ptr){
  return bar2((int*) ptr);
}

int main(int argc, char **argv) {
  using namespace llvm;

  /* If something bad happens, at least print a nice stack trace output */
  sys::PrintStackTraceOnErrorSignal(argv[0]);
  PrettyStackTraceProgram X(argc, argv);

  std::cout << *(foo((int*)argv)) << "\n";
}
