void main() {
  var x;
  x = "saqib";
  print(x.runtimeType); // String

  // reassigned with int type
  x = 10;
  print(x.runtimeType); // int

  // same for dynamic type
  dynamic name;
  name = "saqib";
  print(name.runtimeType);    // String

  name = 10;
  print(name.runtimeType);    // int
}
