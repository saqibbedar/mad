// faulty code: const constructor: below commented code has error, because const constructor is declared and x,y variables are not declared with final keyword which const constructor requires, view solution

// class Point { 
//   double x, y;
  
//   // unnamed constructor
//   Point(this.x, this.y);
  
//   // named constructor
//   Point.origin() : x = 0, y = 0;

//   // const constructor
//   const Point.fixed(this.x, this.y); 
// } 

// solution: all class attributes must be declared with final keyword

class Point { 
  final double x, y;

  // unnamed constructor
  Point(this.x, this.y);

  // named constructor
  Point.origin() : x = 0, y = 0;

  // const constructor
  const Point.fixed(this.x, this.y);
}
