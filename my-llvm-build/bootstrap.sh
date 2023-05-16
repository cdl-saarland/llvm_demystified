set -x

SCRIPT_PATH=$(dirname $(realpath -s $0))
BRANCH=release/14.x

git clone gh:llvm/llvm-project.git -b ${BRANCH}
mkdir -p ${SCRIPT_PATH}/build_llvm
cd ${SCRIPT_PATH}/build_llvm

# Solid developer build
cmake -G Ninja ${SCRIPT_PATH}/llvm-project/llvm \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DLLVM_ENABLE_PROJECTS="clang" \
    -DLLVM_ENABLE_RUNTIMES:STRING="libunwind;libcxxabi;libcxx;compiler-rt;openmp" \
    -DLLVM_LINK_LLVM_DYLIB:BOOL=On \
    -DCLANG_LINK_CLANG_DYLIB:BOOL=On \
    -DLLVM_CCACHE_BUILD=On  \
    -DLLVM_ENABLE_ASSERTIONS:BOOL=ON \
    -DLLVM_PARALLEL_LINK_JOBS=1 \
    -DLLVM_TARGETS_TO_BUILD="X86"

# Remarks:
# Standard cmake flag for the install prefix:
#   -DCMAKE_INSTALL_PREFIX=<eg /usr/local>
#
# NEVER USE:
#   -DBUILD_SHARED_LIBS=On - unsupported, breaks all time time, always prefer a dylib build
#
# You can do static build with -DBUILD_SHARED_LIBS=Off -DLLVM_LINK_LLVM_DYLIB:BOOL=Off \
# Binaries will be huge (in particular with debug builds).
