set -xe

SCRIPT_PATH=$(dirname $(realpath -s $0))

RES=${SCRIPT_PATH}/../res
PLUGIN=${SCRIPT_PATH}/build/PGOAdvisorPlugin.so

echo ">>>> Compile & profile almabench <<<<"
clang -fprofile-generate=raw_profile_almabench/ ${RES}/almabench.c -O3 -lm -o almabench.bin
./almabench.bin
llvm-profdata merge -output=almabench.profdata raw_profile_almabench/*
clang -fprofile-use=almabench.profdata ${RES}/almabench.c -fpass-plugin=${PLUGIN} -O3 -c -S -o /dev/null

# echo ">>>> Clang with 'pgo-advisor' pass. <<<<"
# ${CLANGXX} -fpass-plugin=${PLUGIN} -Rpass=advisor -O2 ${RES}/fft.cpp -emit-llvm -S -o /tmp/null 
# echo ""
# 
# # Calling Bye from opt
# echo ">>>> opt with 'advisor' pass. <<<<"
# ${OPT} -load-pass-plugin=${PLUGIN} -passes='advisor' --pass-remarks-filter=. --pass-remarks-output=/dev/stdout ${RES}/fft.ll -o /tmp/null 
# echo ""
