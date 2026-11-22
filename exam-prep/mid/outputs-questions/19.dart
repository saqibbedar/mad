// faulty code: factory constructors 

// class Point {
//   double x, y;

//   // 1. Unnamed constructor
//   Point(this.x, this.y);

//   // 2. Named constructor
//   Point.origin() : x = 0, y = 0;

//   // 3. Private generative constructor
//   Point._internal();

//   // 4. Named factory constructor
//   factory Point() {
//     return Point._internal();
//   }
// }

// Solution
class Point {
  double x, y;

  // 1. Unnamed constructor
  Point(this.x, this.y);

  // 2. Named constructor
  Point.origin() : x = 0, y = 0;

  // 3. Private generative constructor (must initialize x and y)
  Point._internal(this.x, this.y);

  // 4. Named factory constructor (cannot share the unnamed 'Point' name)
  factory Point.create() {
    return Point._internal(0, 0);
  }
}
