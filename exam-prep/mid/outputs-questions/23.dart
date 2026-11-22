// abstract classes
// 1. can't be instantiated
// 2. can have fields and constructors? yes
// 3. can have method bodies? yes
// 4. primary purpose: share code and state via extend

abstract class Shape {
  // no body here; subclass must write it
  double area();
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);

  @override
  double area() => 3.14 * radius * radius;
}

void main() {
  //   var s = Shape(10);
}
