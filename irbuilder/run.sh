SCRIPT_PATH=$(dirname $(realpath -s $0))

RES=${SCRIPT_PATH}/../res
PLUGIN=${SCRIPT_PATH}/build/EmulateMulDivPlugin.so
PLUGIN_SOLUTION=${SCRIPT_PATH}/build/solution/EmulateMulDivPluginSolution.so

echo ">>>> Clang with 'emulate-muldiv-solution' pass. <<<<"
${CLANGXX} -std=c++20 -fpass-plugin=${PLUGIN_SOLUTION} -march=znver4 -O3 -g0 ${RES}/div.cpp -emit-llvm -fno-discard-value-names -S -o div_solution.ll
${CLANGXX} -O3 div_solution.ll -o div_solution
./div_solution 50 4
./div_solution 50 5
echo ""

grep "udiv i" div_solution.ll > /dev/null
if [[ $? -eq 0 ]]; then
    echo "There's still a udiv in the IR!"
    grep "udiv i" div_solution.ll
    echo ""
fi

grep "mul i" div_solution.ll > /dev/null
if [[ $? -eq 0 ]]; then
    echo "There's still a mul in the IR!"
    grep "mul i" div_solution.ll
fi


echo ">>>> Clang with 'emulate-muldiv' pass. <<<<"
${CLANGXX} -std=c++20 -fpass-plugin=${PLUGIN} -march=znver4 -O3 -g0 ${RES}/div.cpp -emit-llvm -fno-discard-value-names -S -o div.ll
${CLANGXX} -O3 div.ll -o div
./div 50 4
./div 50 5

echo ""

grep "udiv i" div.ll > /dev/null
if [[ $? -eq 0 ]]; then
    echo "There's still a udiv in the IR!"
    grep "udiv i" div.ll
fi

grep "mul i" div.ll > /dev/null
if [[ $? -eq 0 ]]; then
    echo "There's still a mul in the IR!"
    grep "mul i" div.ll
fi

