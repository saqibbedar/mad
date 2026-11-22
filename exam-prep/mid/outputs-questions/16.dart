// Set
void main() {
  var a = {1, 2, 3, 3};
  print(a); // {1, 2, 3}
  print(a.length); // 3

  var b = {2, 3, 4};

  // set operations
  print(a.union(b));  // {1, 2, 3, 4}
  print(a.intersection(b)); // {2, 3}
  print(a.difference(b)); // {1}
}
