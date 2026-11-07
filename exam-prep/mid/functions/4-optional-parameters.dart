// Optional parameters can be written in two ways 

// conventional way
int sum({int a = 0, int b = 0}) {
  return a + b;
}

// 2. dart subscript syntax
int sum2(int a, int b, [int x=0, int y=0, int z = 0]) {
  return a + b + x + y + z;
}

void main() {
  print(sum(a: 10, b: 20));

  print(sum2(10, 10, 10, 5, 5));
}