void main() {
  // Growable list by default (growable: true)
  var squares = List<int>.generate(5, (index) => index * index);
  print(squares); // Output: [0, 1, 4, 9, 16]

  // Fixed-length list with dynamic strings
  var labels = List<String>.generate(
    3,
    (index) => 'Item ${index + 1}',
    growable: false,
  );
  print(labels); // Output: [Item 1, Item 2, Item 3]
}
