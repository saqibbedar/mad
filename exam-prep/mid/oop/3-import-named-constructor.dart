import '2-named-constructor.dart';

void main() {
  var p1 = Point(1, 2);
  var p2 = Point.origin();
  print(p1.x);
  print(p2.x);
}
