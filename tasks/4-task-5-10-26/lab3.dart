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

  // Task 8.1
  @override
  String toString() => '$name (Rs $price)';
}

// Task 4.1
class OrderLog {
  // Think: `_instance` and `_internal` are prefixed with `_` to make them private.
  // If public, outside code could directly call `OrderLog.internal()` or reassign `instance`,
  // bypassing the factory and breaking the singleton guarantee.
  static OrderLog? _instance;
  final List<String> entries = [];

  // Private generative constructor (cannot be called from outside this file)
  OrderLog._internal(); // private named constructor

  // Factory constructor: always returns the singleton instance
  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  }

  void add(String msg) => entries.add(msg);
}

// Task 5
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  OrderLine(this.item, this.qty)
    : total = item.price * qty,
      tax = (item.price * qty) * taxPercent ~/ 100,
      assert(qty > 0, 'qty must be positive');

  // Think: An initializer list cannot access `this` or other instance fields like `total`
  // because the object is not yet fully constructed. We must compute `tax` from the parameters directly.

  // ---------------- Task 6.1 ------------------
  // getters
  // Think: `line.grand = 5` fails because `grand` is defined only as a getter (read-only).
  // To make assignment legal, a corresponding setter `set grand(int value)` would need to be added.
  int get grand => total + tax;
  bool get isBigOrder => grand > bigOrderLimit;
  String get label => '${item.name} x$qty';
}

OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

// Task 7
class StudentCard {
  final String owner;
  int _balance; // private backing field

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  // Task 7.1: Setter with clamping logic
  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }

  // Think: Instead of silently clamping, a setter could throw an exception
  // (e.g. ArgumentError / RangeError) or reject the update by keeping the previous value.
}

// Task 8.2 (top level function)
List<MenuItem> buildMenu() {
  final List<MenuItem> items = [];
  for (int k = 0; k < 4; k++) {
    final int idx = (u + 3 * k) % 10;
    items.add(MenuItem.fromString('${menu[idx]}:${priceOf(idx)}'));
  }
  return items;
}

// Task 9.1
List<OrderLine> buildReceipt() {
  final items = buildMenu();
  return [for (int k = 0; k < 3; k++) OrderLine(items[k], 1 + (t + k) % 4)];
}

// Task 10
class Coupon {
  static final Map<String, Coupon> _cache = {};

  final String code;
  final int percent;
  final int minSpend;

  // Main constructor with initializer list and assertion
  Coupon(this.code, this.percent)
    : minSpend = percent * 70,
      assert(percent >= 1 && percent <= 50, 'percent must be between 1 and 50');

  // Factory constructor querying the cache
  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(code, () => Coupon(code, couponPercent));
  }

  // Method to calculate discount
  int discountOn(int amount) {
    if (amount >= minSpend) {
      return amount * percent ~/ 100;
    }
    return 0;
  }
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

  final freebie = MenuItem.free('Water');
  final int i = (u + 2) % 10;
  final parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');
  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
}

void step4() {
  print('--- Step 4 ---');

  final log1 = OrderLog();
  final log2 = OrderLog();

  for (int i = 1; i <= u + 2; i++) {
    final msg = 'order #${100 * t + i}';
    if (i % 2 != 0) {
      log1.add(msg);
    } else {
      log2.add(msg);
    }
  }

  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
}

void step5() {
  print('--- Step 5 ---');

  final line = mainOrder();

  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0); // line = your mainOrder() result
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
}

void step6() {
  print('--- Step 6 ---');
  final line = mainOrder();

  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${line.label}');
}

void step7() {
  print('--- Step 7 ---');
  final card = StudentCard('S$seed');

  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');

  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');

  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');

  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order -> ${card.balance}');
}

void step8() {
  print('--- Step 8 ---');
  final items = buildMenu();
  final priciest = items.reduce((a, b) => a.price > b.price ? a : b);
  final sum = items.fold(0, (acc, item) => acc + item.price);

  print('Step 8: menu = $items');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}

void step9() {
  print('--- Step 9 ---');
  final receipt = buildReceipt();
  final log = OrderLog();

  for (final line in receipt) {
    print('Step 9: ${line.label} = ${line.grand}');
    log.add('receipt: ${line.label}');
  }

  final receiptTotal = receipt.fold(0, (sum, line) => sum + line.grand);
  print('Step 9: receipt total = $receiptTotal');
  print('Step 9: log size = ${log.entries.length}');
}

void step10() {
  print('--- Step 10 ---');
  final code = 'CAFE${seed.toString().padLeft(2, '0')}';
  final c1 = Coupon.fromCode(code);
  final c2 = Coupon.fromCode(code);

  final receiptLines = buildReceipt();
  final receipt = receiptLines.fold(0, (sum, line) => sum + line.grand);
  final discount = c1.discountOn(receipt);

  print(
    'Step 10: ${c1.code} gives ${c1.percent}% off, min spend ${c1.minSpend}',
  );
  print('Step 10: cached? ${identical(c1, c2)}');
  print(
    'Step 10: receipt $receipt, discount $discount, payable ${receipt - discount}',
  );
}

// -------------------- Note ----------------------
// public/report.odt is a libre file, containing all task wise screenshots
// ------------------------------------------------

// --- QUESTIONS ---

// Q1. Animal(this.name, this.type); and the verbose constructor give the same result. What does the shorthand save you?

// Ans: It removes boilerplate parameter-to-field assignments (this.name = name;) and ensures non-nullable fields are initialized before the constructor body executes.

// Q2. When would you choose a named constructor, and when a factory constructor?

// Ans: Use a named constructor to provide distinct ways to instantiate a new object (e.g., MenuItem.free). Use a factory constructor when you need to return a cached instance or subtype rather than always allocating a new instance.

// Q3. What is the difference between assigning a field in a constructor body and assigning it in an initializer list?

// Ans: The initializer list runs before the body and can initialize final non-nullable fields, whereas the constructor body runs after object creation and cannot assign to final fields.

// Q4. Give one reason to use a getter instead of storing the value in a field, and one reason to use a setter instead of a public field.
// Ans: A getter allows dynamically computing derived values on-demand without storing redundant state; a setter allows intercepting assignments to validate or clamp incoming values before updating state.
