// lab3.dart  -  Campus Cafe Order System
// Name: Muhammad Saqib   Roll no: 04072313037

const String rollNo = '04072313037'; // e.g. '2100672347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];
int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;
// ===========================================================================

// Task 1.1: Dish
class Dish {
  late String name;
  late int price;
}

// Task 2.2: MenuItem
class MenuItem {
  // Think: `price` cannot be final because we reassign it inside the constructor body when clamping it to `priceFloor`.

  // Because, final field can only be assigned once. By using MenuItem(this.name, this.price), the field is already initialized. If price were marked final, the line this.price = priceFloor; inside the constructor body would cause a compilation error: "The final variable 'price' can only be set once".

  String name;
  int price;

  // verbose constructor
  // MenuItem(String name, int price) {
  //   this.name = name;
  //   this.price = price;
  // }

  // shorthand & Task 2.2 (conditional)
  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }

  // Think: The floor logic did not run because MenuItem.free is an independent 
  // constructor and does not execute the default constructor's body.

  // Task 3.1: Named constructor for free items
  MenuItem.free(this.name) : price = 0;

  // Task 3.2: Named constructor parsing 'name:price' string
  MenuItem.fromString(String text)
    : name = text.split(':')[0],
      price = int.parse(text.split(':')[1]);
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

void step1() {
  print('--- Step 1 ---');

  // Task 1.2
  final item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  final item2 = Dish();
  final int idx2 = (u + 1) % 10;
  item2.name = menu[idx2];
  item2.price = priceOf(idx2);
  item2.price = item2.price - u;

  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 2: ${item2.name} Rs ${item2.price}');
}

void step2() {
  print('--- Step 2 ---');
  final a = MenuItem(menu[u], priceOf(u));
  final b = MenuItem('Test Special', 15 * u);

  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: Test special Rs ${b.price}');
}

void step3() {
  print('--- Step 3 ---');

  final freebie = MenuItem.free('Water');
  final int i = (u + 2) % 10;
  final parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');
  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
}

void step4() {
  print('--- Step 4 ---');
}

void step5() {
  print('--- Step 5 ---');
}

void step6() {
  print('--- Step 6 ---');
}

void step7() {
  print('--- Step 7 ---');
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}
