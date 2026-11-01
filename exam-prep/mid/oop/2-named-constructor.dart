// Named constructors are called without class instance and they always return a brand new instance
// useful for various cases

// syntax: 
//  class className {
//      className.constructorName(){}
// }
//
//

class Point{
  double x;
  double y;

  Point(this.x, this.y);

  // named constructor
  Point.origin() : x = 0, y = 0;
}