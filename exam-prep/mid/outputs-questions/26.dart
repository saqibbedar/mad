abstract class Shape {
  double area();
  String describe() => 'Area: ${area()}';
}

mixin Sortable on Shape {
  int compareByArea(Shape o) => area().compareTo(o.area());
}

class Circle extends Shape with Sortable {
  final double r;
  new(this.r);

  @override
  double area() => 3.14 * r * r;
}

class Rectangle extends Shape with Sortable {
  final double w, h;
  new(this.w, this.h);

  @override
  double area() => w * h;
}

class Square extends Rectangle {
  Square(double side) : super(side, side);
}

void main() {
  List<Shape> shapes = [Circle(3), Rectangle(4, 5), Square(3)];

  shapes.sort((a, b) => a.area().compareTo(b.area()));

  for (var shape in shapes) {
    print(shape.area());
  }

  /** Output:
   * 9.0
   * 20.0
   * 28.259999999999998
  */
}
