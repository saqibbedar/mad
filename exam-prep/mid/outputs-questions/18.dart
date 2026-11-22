// class: attributes + methods
// constructor: shares classname and created on instantiation of an object

// Two types of constructors:
// 1. unnamed constructors (generative constructors): ClassName() -> traditional main constructor
// 2. named constructors: ClassName.method()
// 3. const constructors: declared with const

// Further types:
// 4. Factory constructors
// 4.1. unnamed factory constructors: factory ClassName(){}
// 4.2. named factory constructors: factory ClassName.method(){}

class Animal {
  String name, type;
  // unnamed constructor
  Animal(this.name, this.type);
}

// Named constructors: use classname and add new method using dot notation, so named constructors are direct methods created with classname
class Point {
  double x, y;

  // unnamed constructor
  Point(this.x, this.y);

  // named constructors -> syntax: ClassName.methodName()
  Point.origin() : x = 0, y = 0;

  // const constructor -> syntax: const ClassName.methodName()
  // const Point.fixed(this.x, this.y); [this will throw error because variable x and y are not declared final, for const constructors class attributes must be declared using final keyword.]
}

// factory constructor
class Logger {
  // =============== Important ================
  // for factory constructor, we must create a private generative constructor
  Logger._internal();

  // factory constructor
  factory Logger() {
    return Logger._internal();
  }
}

// factory other syntax
class Log2 {
  int x;
  Log2._internal(this.x);

  factory Logger() {
    return Log2._internal(0);
  }
}

void main() {
  var dog = Animal("Rex", "Dog");
  print("${dog.type}: ${dog.name}"); // Dog: Rex

  // named constructors
  var p = Point.origin();
  print(p); // Instance of 'Point'
  print("(${p.x}, ${p.y})"); // (0.0, 0.0)
}
