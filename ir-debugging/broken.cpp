#include <algorithm>

struct Data {
  int P[10];
};

int foo(int a, Data Array) {
  int D[10];
  std::copy(Array.P, Array.P+10, D);
  if (a >= 0)
    a = -1;
  return D[a]; // oob access
}
