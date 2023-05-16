# Naively trying to compile
clang++ -std=c++20 -emit-llvm -S -c broken.cpp -O3 -o broken.ll

# Get the driver invocation
clang++ -### -std=c++20 -emit-llvm -S -c broken.cpp -O3 -o broken.ll

cat broken.ll

# UndefValue con
gdb \
    -ex set breakpoint pending on \
    -ex b llvm::UndefValue::UndefValue \
    -ex b llvm::PoisonValue::PoisonValue \
    -ex b llvm::UnreachableInst::UnreachableInst \
    --args "/home/simon/llvm_demyst/install/bin/clang-16" "-cc1" "-triple" "x86_64-unknown-linux-gnu" "-emit-llvm" "-disable-free" "-clear-ast-before-backend" "-main-file-name" "broken.cpp" "-mrelocation-model" "pic" "-pic-level" "2" "-pic-is-pie" "-mframe-pointer=none" "-fmath-errno" "-ffp-contract=on" "-fno-rounding-math" "-mconstructor-aliases" "-funwind-tables=2" "-target-cpu" "x86-64" "-tune-cpu" "generic" "-mllvm" "-treat-scalable-fixed-error-as-warning" "-debugger-tuning=gdb" "-fcoverage-compilation-dir=/home/simon/llvm_demyst/llvm-demystified/ir-debugging" "-resource-dir" "/home/simon/llvm_demyst/install/lib/clang/16" "-I/home/simon/llvm_demyst/install/include" "-I/opt/scipsuite_803/include" "-I/home/simon/local/gurobi/include" "-I/home/simon/.local/include" "-I/opt/scipsuite_803/include" "-I/home/simon/local/gurobi/include" "-I/home/simon/.local/include" "-I." "-internal-isystem" "/usr/lib64/gcc/x86_64-pc-linux-gnu/13.1.1/../../../../include/c++/13.1.1" "-internal-isystem" "/usr/lib64/gcc/x86_64-pc-linux-gnu/13.1.1/../../../../include/c++/13.1.1/x86_64-pc-linux-gnu" "-internal-isystem" "/usr/lib64/gcc/x86_64-pc-linux-gnu/13.1.1/../../../../include/c++/13.1.1/backward" "-internal-isystem" "/home/simon/llvm_demyst/install/lib/clang/16/include" "-internal-isystem" "/usr/local/include" "-internal-isystem" "/usr/lib64/gcc/x86_64-pc-linux-gnu/13.1.1/../../../../x86_64-pc-linux-gnu/include" "-internal-externc-isystem" "/include" "-internal-externc-isystem" "/usr/include" "-O3" "-std=c++20" "-fdeprecated-macro" "-fdebug-compilation-dir=/home/simon/llvm_demyst/llvm-demystified/ir-debugging" "-ferror-limit" "19" "-fgnuc-version=4.2.1" "-fno-implicit-modules" "-fcxx-exceptions" "-fexceptions" "-fcolor-diagnostics" "-vectorize-loops" "-vectorize-slp" "-faddrsig" "-D__GCC_HAVE_DWARF2_CFI_ASM=1" "-o" "broken.ll" "-x" "c++" "broken.cpp"



#### -### Output on our training VM. We provide an optimized LLVM build, so the ctor calls are likely optimized out and do not trigger in gdb
### We advise you to use a debug+dylib of LLVM to retain the ability to break on trivial ctors/funcs.
# /usr/lib/llvm-16/bin/clang -cc1 -triple x86_64-pc-linux-gnu -emit-llvm -disable-free -clear-ast-before-backend -disable-llvm-verifier -discard-value-names -main-file-name broken.cpp -mrelocation-model pic -pic-level 2 -pic-is-pie -mframe-pointer=none -fmath-errno -ffp-contract=on -fno-rounding-math -mconstructor-aliases -funwind-tables=2 -target-cpu x86-64 -tune-cpu generic -mllvm -treat-scalable-fixed-error-as-warning -debugger-tuning=gdb -fcoverage-compilation-dir=${HOME}/llvm_demyst/ir-debugging -resource-dir /usr/lib/llvm-16/lib/clang/16 -internal-isystem /usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/c++/10 -internal-isystem /usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/x86_64-linux-gnu/c++/10 -internal-isystem /usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/c++/10/backward -internal-isystem /usr/lib/llvm-16/lib/clang/16/include -internal-isystem /usr/local/include -internal-isystem /usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../x86_64-linux-gnu/include -internal-externc-isystem /usr/include/x86_64-linux-gnu -internal-externc-isystem /include -internal-externc-isystem /usr/include -O3 -std=c++20 -fdeprecated-macro -fdebug-compilation-dir=${HOME}/llvm_demyst/ir-debugging -ferror-limit 19 -fgnuc-version=4.2.1 -fno-implicit-modules -fcxx-exceptions -fexceptions -fcolor-diagnostics -vectorize-loops -vectorize-slp -faddrsig -D__GCC_HAVE_DWARF2_CFI_ASM=1 -o broken.ll -x c++ broken.cpp
