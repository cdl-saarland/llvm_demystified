#! /bin/bash

clang++ -O -Xclang -disable-llvm-optzns -fno-discard-value-names -g0 04.cpp -S -emit-llvm -o 04.ll
opt -passes=sroa 04.ll -o 04_sroa.ll -S
sed -i "s/%add = add i64 %acc.0, %mul/%add = mul i64 %acc.0, %mul/g" 04_sroa.ll
sed -i "s/%acc.0 = phi i64 \[ 0, %entry \], \[ %add, %for.inc \]/%acc.0 = phi i64 \[ 1, %entry \], \[ %add, %for.inc \]/g" 04_sroa.ll

lli 04_sroa.ll 4
clang++ 04_sroa.ll -o 04_mul
./04_mul 2
