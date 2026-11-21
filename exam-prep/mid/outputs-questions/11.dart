void main() {
  var nums = [1, 5, 2, 4, 3, 3, 4, 2, 5, 1];

  // add/remove/sort mutate/change the list in place

  nums.add(6);
  print(nums); // [1, 5, 2, 4, 3, 3, 4, 2, 5, 1, 6]

  nums.remove(1); // remove first occurrence
  print(nums); // [5, 2, 4, 3, 2, 4, 2, 5, 1, 6]

  nums.sort();
  print(nums); // [1, 2, 2, 3, 3, 4, 4, 5, 5, 6]

  print(nums.contains(6)); // true

  // ===== Powerful Methods =====

  nums.forEach((n) => print(n));

  print(nums.where((n) => n.isEven)); // (2, 2, 4, 4, 6)

  print(nums.map((n) => n * 2)); // (2, 4, 4, 6, 6, 8, 8, 10, 10, 12)

  print(nums.reduce((a, b) => a + b));  // 35

  // print(nums.fold(100, (a, b) => a + b)); // compile-time error
  // Explanation: This throws a compile-time error because print() accepts Object?, causing Dart's type inference to guess the accumulator a is of type Object? instead of int. Since Object? does not have a + operator, a + b fails.

  // solution
  // a: define the type
  print(nums.fold<int>(100, (a, b) => a + b)); // 135

  // b: save final value in a result or total variable and then print it
  var total = nums.fold(100, (a, b) => a + b);
  print(total); // 135
}
