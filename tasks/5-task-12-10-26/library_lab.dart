// library_lab.dart  -  Campus Library System
// Name: Muhammad Saqib   Roll no: 04072313037

const String rollNo = '04072313037';   // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;   // tens digit
final int u = seed % 10;    // units digit

const List<String> titles = [
  'Dart Basics', 'Flutter In Action', 'Data Structures', 'Operating Systems',
  'Mobile Design', 'Clean Code', 'Algorithms Unlocked', 'Computer Networks',
  'Database Systems', 'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;      // publication year of titles[i]
final int feePerDay = 5 + t;                // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6;       // normal number of days late
final int daysBig = 10 + u;                 // a long overdue period
final int feeCap = 150 + 10 * t;            // no single fee may exceed this
final int renewLimit = 1 + t % 3;           // renewals allowed per item
final int renewAttempts = 2 + u;            // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4;            // items on the shelf in Steps 9-10
// ===========================================================================

// Think: Abstract classes cannot be instantiated because they represent incomplete 
// blueprints with unimplemented methods (e.g., lateFee has no body).
// Task 1.1: Base class
abstract class LibraryItem {
  final String title;
  final int year;
  LibraryItem(this.title, this.year);

  // Task 2.1: Base describe method
  String describe() => '$title ($year)';

   // Task 3.1: Abstract method
  int lateFee(int days);
}

// Think: `item.pages` is a compile-time error because static type checking relies on 
// the variable's declared type (LibraryItem), which does not declare `pages`.

// Task 1.2: Subclass with super parameters
class Book extends LibraryItem {
  final int pages;
  Book(super.title, super.year, this.pages);

  // Task 2.2: Reuses parent's describe via super.describe()
  @override
  String describe() => '${super.describe()}, $pages pages';

  // Task 3.2: Book late fee
  @override
  int lateFee(int days) => days * feePerDay;
}

// Task 1.3: Top-level (utility) function
Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

// Task 2.3

// Think: Without @override, mistyping the name as `descibe()` would silently declare 
// a new method instead of overriding, causing calls to `describe()` to run the parent's version.
class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  // Task 3.2: Magazine late fee (~/ is integer division)
  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

Magazine mainMagazine() {
  final int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

// Task 3.2
class Dvd extends LibraryItem {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Dvd mainDvd() {
  final int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}


void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

//=========== Step 1 ===========

void step1() {
  print('--- Step 1 ---');
  final b = mainBook();
  final LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
}

//=========== Step 2 ===========

void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
}

//=========== Step 3 ===========

void step3() {
  print('--- Step 3 ---');
  print(
    'Step 3: Book late fee for $daysLate days = ${mainBook().lateFee(daysLate)}',
  );
  print(
    'Step 3: Magazine late fee for $daysLate days = ${mainMagazine().lateFee(daysLate)}',
  );
  print(
    'Step 3: Dvd late fee for $daysLate days = ${mainDvd().lateFee(daysLate)}',
  );
}

//=========== Step 4 ===========

void step4() { print('--- Step 4 ---'); }

//=========== Step 5 ===========

void step5() { print('--- Step 5 ---'); }

//=========== Step 6 ===========

void step6() { print('--- Step 6 ---'); }

//=========== Step 7 ===========

void step7() { print('--- Step 7 ---'); }

//=========== Step 8 ===========

void step8() { print('--- Step 8 ---'); }

//=========== Step 9 ===========

void step9() { print('--- Step 9 ---'); }

//=========== Step 10 ===========

void step10() { print('--- Step 10 ---'); }
