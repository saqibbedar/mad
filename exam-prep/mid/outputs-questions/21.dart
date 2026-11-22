// inheritance (extends: is a)

class Animal {
  String name;
  new(this.name);
}

class Dog extends Animal {
  new(super.name);
}

void main() {
  var d = Dog('Rex');
  print(d.name);

  Animal a = Dog('Max');
  print(a.name);

  // Dog x = Animal('Zed'); // type error
}
