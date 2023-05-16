set -ex

SCRIPT_PATH=$(dirname $(realpath -s $0))

RES=${SCRIPT_PATH}/../res

# Building Bye
mkdir -p build
cd build
cmake -G Ninja ../
ninja
cd ../
