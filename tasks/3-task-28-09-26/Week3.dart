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

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
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

Map<String, dynamic> makeBook({required String title, required String author, 
int year = 2024, int copies = 1}) {
  return {
    'title': title,
    'author': author,
    'year': year,
    'copies': copies
  };
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
}

void part4() {
  print('--- Part 4 ---');
}

void part5() {
  print('--- Part 5 ---');
}

Future<void> part6() async {
  print('--- Part 6 ---');
}
