set -ex

SCRIPT_PATH=$(dirname $(realpath -s $0))

mkdir -p ${SCRIPT_PATH}/build
cd ${SCRIPT_PATH}/build
cmake -G Ninja ${SCRIPT_PATH}
ninja
cd ${SCRIPT_PATH}
