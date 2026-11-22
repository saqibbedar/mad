// super and overriding methods

class Animal() {
  void speak() => print("...");
}

class Dog extends Animal {
  @override
  void speak() {
    super.speak(); // call parents function
    print("woof!");
  }
}

void main() {
  Dog().speak();
}
