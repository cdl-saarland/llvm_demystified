// clang++ -O3 02.cpp -o 02 && ./02 100
// clang++ -O -Xclang -disable-llvm-optzns -fno-discard-value-names -g0 02.cpp -S -emit-llvm -o 02.ll

#include <iostream>
#include <numeric>
#include <vector>

int dot_product(const int *a, const int *b, const std::size_t size) {
  int acc = 0;
  for (int i = 0; i < size; ++i)
    acc += a[i] * b[i];

  return acc;
}

int main(int argc, const char *argv[]) {
  std::size_t size = 100;
  if(argc > 1)
    size = std::atoll(argv[1]);
  std::vector<int> a(size);
  std::vector<int> b(size);

  // init a: 0-99, b: 100-199
  std::iota(a.begin(), a.end(), 0);
  std::iota(b.begin(), b.end(), size);

  int acc = dot_product(a.data(), b.data(), size);

  std::cout << "a o b = " << acc << "\n";
  return 0;
}
