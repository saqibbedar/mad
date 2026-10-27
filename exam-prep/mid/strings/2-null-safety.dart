void main() {
  String name = "Saqib";

  // String str;  // error not nullable (a string must always be initialized)

  // Fix: make string nullable by adding ? to datatype
  String? somestr;
  print(somestr);   // output: null
  // print(somestr.length); // error because .length cannot be accessed on String? as its null
  
  late String description;

  // print(description.length); // Error: a late local variable must be initialized before runtime
}