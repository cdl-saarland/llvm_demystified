SCRIPT_PATH=$(dirname $(realpath -s $0))

RES=${SCRIPT_PATH}/../res
PLUGIN=${SCRIPT_PATH}/build/AdvisorPlugin.so

echo ">>>> Clang with 'advisor' pass. <<<<"
clang++ -fpass-plugin=${PLUGIN} -Rpass=advisor -O2 ${RES}/fft.cpp -emit-llvm -S -o /tmp/null 
echo ""

# Calling Bye from opt
echo ">>>> opt with 'advisor' pass. <<<<"
opt -load-pass-plugin=${PLUGIN} -passes='advisor' --pass-remarks-filter=. --pass-remarks-output=/dev/stdout ${RES}/fft.ll -o /tmp/null 
echo ""
