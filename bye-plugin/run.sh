set -ex

SCRIPT_PATH=$(dirname $(realpath -s $0))
RES=${SCRIPT_PATH}/../res

# Running bye
CLANG=clang
OPT=opt
PLUGIN=${SCRIPT_PATH}/build/ByePlugin.so

# Calling Bye from opt
echo ">>>> opt with 'goodbye' pass. <<<<"
${OPT} -load-pass-plugin=${PLUGIN} -passes='goodbye' ${RES}/simple.ll -o /tmp/null 
echo ""

echo ">>>> opt with 'goodbye' pass and '-wave-goodbye' option. <<<<"
${OPT} -load-pass-plugin=${PLUGIN} -passes='goodbye' -wave-goodbye ${RES}/simple.ll -o /tmp/null 
echo ""

# Calling Bye from Clang
echo ">>>> Clang with 'goodbye' pass. <<<<"
${CLANG} -fpass-plugin=${PLUGIN} ${RES}/simple.c -O1 -c -o /dev/null
echo ""

# FIXME: How to pass that to clang?
# echo ">>>> Clang with 'goodbye' pass and flag. <<<<"
# ${CLANG} -fpass-plugin=${PLUGIN} -mllvm -wave-goodbye ${RES}/simple.c -O1 -c -o /dev/null # TODO How to pass

