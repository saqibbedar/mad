// Week3.dart  -  Library Desk Assistant
// Name: Muhammad Saqib   Roll no: 04072313037

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

// Part4
// 4.1
class Box<T> {
  T value;
  Box(this.value);
}

// 4.2
T firstOr<T>(List<T> items, T fallback) {
  if (items.isEmpty) {
    return fallback;
  }
  return items.first;
}

// 4.3
class Pair<A, B> {
  A first;
  B second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return '($first, $second)';
  }
}

// Part 5
// 5.1
class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
}

// 5.2
void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }
  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

// 5.4
Map<String, dynamic> findBook(String title) {
  return books.firstWhere((b) => b['title'] == title);
}

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
  await bonus();
}

void part1() {
  print('--- Part 1 ---');

  // 1.1
  double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;
  print(lateFee(5, 0.5));

  // 1.2
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));

  // 1.3
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));

  // 1.4
  bool isClassic(int year) => year < 2000;
  print(isClassic(1968));
  print(isClassic(2021));
}

// Part 1 (utility functions)
String formatTitle(String title, [String? author]) {
  return author == null ? title : '$title by $author';
}

Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

void part2() {
  print('--- Part 2 ---');

  // 2.1
  List<String> bookNames = ['Dart in Action', 'Clean Code'];
  print(
    transformAll(bookNames, (String s) {
      return s.toUpperCase();
    }),
  );
  print(transformAll(bookNames, (s) => '$s!'));

  // 2.2
  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  // 2.3
  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  // 2.4
  print('Sum of digits: ${sumDigits(17)}');
}

// part2 (Utility functions)
List<String> transformAll(List<String> items, String Function(String) fn) {
  return items.map(fn).toList();
}

int Function() makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

double Function(int) makeFeeCalculator(double rate) {
  return (int days) => days * rate;
}

int sumDigits(int n) {
  if (n < 10) {
    return n;
  }
  return (n % 10) + sumDigits(n ~/ 10);
}

void part3() {
  print('--- Part 3 ---');

  // 3.1
  List<String> titles = books.map((b) => b['title'] as String).toList();
  print('Titles: $titles');

  List<String> available = books
      .where((b) => (b['copies'] as int) > 0)
      .map((b) => b['title'] as String)
      .toList();
  print('Available: $available');

  // 3.2
  int totalCopies = books.fold(0, (sum, b) => sum + (b['copies'] as int));
  print('Total copies: $totalCopies');

  int oldestYear = books
      .map((b) => b['year'] as int)
      .reduce((min, year) => year < min ? year : min);
  print('Oldest year: $oldestYear');

  // 3.3
  var booksCopy = List.of(books);
  booksCopy.sort((a, b) => (a['year'] as int).compareTo(b['year'] as int));
  List<String> sortedTitles = booksCopy
      .map((b) => b['title'] as String)
      .toList();
  print('By year: $sortedTitles');

  // 3.4
  Map<String, int> stock = buildStock();
  print('Stock: $stock');

  stock.forEach((title, copies) {
    if (copies == 0) {
      print('Out of stock: $title');
    }
  });

  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  // 3.5
  Set<String> allTags = {for (var b in books) ...b['tags'] as List<String>};
  print('All tags: $allTags');

  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};

  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

// part3 utility functions
Map<String, int> buildStock() {
  return {for (var b in books) b['title'] as String: b['copies'] as int};
}

void part4() {
  print('--- Part 4 ---');

  // 4.1
  var intBox = Box<int>(5);
  var stringBox = Box<String>('dart');

  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');

  // 4.2
  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'Z'));

  // 4.3
  print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');

  // 5.3
  var stock = buildStock();

  for (String title in ['Dart in Action', 'Flutter Basics', 'Unknown Book']) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } finally {
      print('Transaction logged.');
    }
  }

  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  // 5.4
  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');

  // 6.1 & .2
  print('Fetching...');
  String book = await fetchBookOfTheDay();
  print('Book of the day: $book');

  // 6.3
  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

// last part 6
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server down');
}

// Bonus

List<T> filterBy<T>(List<T> items, bool Function(T) test) {
  List<T> result = [];
  for (T item in items) {
    if (test(item)) {
      result.add(item);
    }
  }
  return result;
}

Future<void> bonus() async {
  print('--- Bonus Work ---');

  // B1
  Map<String, List<String>> titlesByTag = {};
  for (var b in books) {
    String title = b['title'] as String;
    for (String tag in b['tags'] as List<String>) {
      titlesByTag.putIfAbsent(tag, () => []).add(title);
    }
  }
  print('Grouped by tag: $titlesByTag');

  // B2
  var availableBooks = filterBy<Map<String, dynamic>>(
    books,
    (b) => (b['copies'] as int) > 0,
  );
  List<String> availableTitles = availableBooks
      .map((b) => b['title'] as String)
      .toList();
  print('Available (using filterBy): $availableTitles');

  // B3
  Stopwatch stopwatch = Stopwatch()..start();
  await Future.wait([fetchBookOfTheDay(), fetchBookOfTheDay()]);
  stopwatch.stop();
  print(
    'Total time for two parallel fetch calls: ${stopwatch.elapsedMilliseconds} ms',
  );
}

/*
                -------------------- Report -----------------------

1. When would you choose fold over reduce?
You choose fold when you want to supply a safe starting value (preventing crashes on empty lists) or when the result type needs to be different from the list elements.

2. What does it mean that a closure "captures" a variable? Which variable was captured in makeCounter?
It means the function remembers and has access to the variables from the scope in which it was created, even after that scope has finished executing. In makeCounter, the 'count' variable was captured.

3. Why must on BookNotAvailableException come before a general catch (e)?
Because Dart checks catch clauses top-to-bottom. A general catch (e) would swallow the error, meaning the specific BookNotAvailableException block would never be reached.

4. Why does forgetting await still compile, but give the wrong result?
Because the function correctly returns a Future object immediately. It compiles fine, but prints the literal Future instance rather than waiting for the resolved underlying data.
*/
