// clang++ -O3 03.cpp -o 03 && ./03 100
// clang++ -O -Xclang -disable-llvm-optzns -fno-discard-value-names -g0 03.cpp -S -emit-llvm -o 03.ll

#include <string>
#include <cstdlib>
#include <cstdio>

std::int64_t relu(std::int64_t num) {
    return num > 0 ? num : 0;
}

int main(int argc, const char *argv[]) {
  std::int64_t num = 100;
  if(argc > 1)
    num = std::atoll(argv[1]);

  std::printf("relu(%ld) = %ld\n", num, relu(num));
  return 0;
}
