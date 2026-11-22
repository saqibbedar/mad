// mixins: used for helpful functions

class Animal {}

mixin Flyer {
  void fly() => print('flying');
  void sleep() => print('sleeping');
}

// inhering(extending) animal functionalities along with Flyer's cool functions
class Bird extends Animal with Flyer {}

// No animal
class Plane with Flyer {}

void main() {
  Bird().fly(); // flying
  Bird().sleep(); // sleeping

  Plane().fly(); // flying
  Plane().sleep(); // sleeping
}
