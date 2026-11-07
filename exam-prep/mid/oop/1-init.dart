// Dart don't have protected or private security support for class variables like in cpp we have but it does support privacy at file level, if a variable is written with `_` as prefix then its private for other files but within this file its not private.

// class x{int _var;}
// then in other file its not accessible x._x // error
// but in this file it is. x._x // no error

class Student {
  String name;
  int age;

  // A constructor shares the class's name and runs on creation
  // this.name auto-assigns a constructor argument to the field
  // Constructor bodies can run extra logic, not just assignment
  Student(this.name, this.age);

  void show(){
    print("Student(name=$name, age=$age)");
  }
}

void main() {
  var s1 = Student("Saqib Bedar", 22);
  s1.show();
}