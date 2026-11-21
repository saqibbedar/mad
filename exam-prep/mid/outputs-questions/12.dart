void main() {
  // Fixed-length list by default (growable: false)
  var fixedScores = List<int>.filled(4, 0);
  print(fixedScores); // Output: [0, 0, 0, 0]
  // fixedScores.add(10); // Throws UnsupportedError: Cannot add to a fixed-length list

  // Growable list (growable: true)
  var growableTags = List<String>.filled(3, 'pending', growable: true);
  growableTags.add('completed');
  print(growableTags); // Output: [pending, pending, pending, completed]

  // Interview
  // WRONG: All 3 inner lists point to the exact same list instance
  var badGrid = List.filled(3, [0, 0]);
  badGrid[0][0] = 9;
  print(badGrid); // Output: [[9, 0], [9, 0], [9, 0]]

  // RIGHT: Each inner list is a separate instance
  var goodGrid = List.generate(3, (_) => [0, 0]);
  goodGrid[0][0] = 9;
  print(goodGrid); // Output: [[9, 0], [0, 0], [0, 0]]
}
