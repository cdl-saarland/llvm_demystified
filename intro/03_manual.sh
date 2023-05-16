#! /bin/bash

clang++ -O -Xclang -disable-llvm-optzns -g0 03.cpp -emit-llvm -fno-discard-value-names -c -o 03.bc # Parse C++ to LLVM IR
llvm-dis 03.bc -o 03.ll                                                   # Disassemble IR (skip: -c -> -S above)
llvm-extract --func=_Z4relul 03.ll -o 03_relu.ll -S                       # Extract relu
llvm-extract --func=main 03.ll -o 03_main.ll -S --keep-const-init         # Extract main (and const inits)
opt 03_relu.ll -passes="sroa,simplifycfg" -S -o 03_relu_opt.ll            # Simplify relu
llvm-link 03_relu_opt.ll 03_main.ll -o 03_full.ll -S                      # Link optimized relu and main again
llvm-as 03_full.ll -o 03_full.bc                                          # Assemble IR to bitcode (optional)

# Run using interpreter
lli 03_full.bc 10

# Compile BC to assembly
llc 03_full.bc -o 03_full.s

# Compile BC (and link) to executable
clang 03_full.bc -o 03_full
./03_full

# Reduce the IR to only branches & phi node
llvm-reduce 03_relu.ll --test="/usr/bin/grep" --test-arg="phi"
