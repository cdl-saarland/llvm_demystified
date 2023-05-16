struct Data {
  int P[10];
};

int foo(int a, Data Array) {
  if (a > 42) {
    a = -1;
  }
  if (a >= 0)
    a = -1;
  return Array.P[a]; // Access is always out of bounds. LLVM fails to recognize this.
}
