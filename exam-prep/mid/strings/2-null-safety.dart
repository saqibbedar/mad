void main() {
  String name = "Saqib";

  // String str;  // error not nullable (a string must always be initialized)

  // Fix: make string nullable by adding ? to datatype
  String? somestr;
  print(somestr);   // output: null
  // print(somestr.length); // error because .length cannot be accessed on String? as its null
  
  // alternatively, we can use late or String? to initialized it later
  late String description;
  
  // But, again error on accessing its methods:
  // print(description.length); // Error: a late local variable must be initialized before runtime

  // ================ Fix ===================
  // Approach 1: we can use bang operator and it allows us to access object methods but it is strict for null, if an object is actually null then expect type error

  // example using bang `!`
  String? xyz;
  // print(xyz!.length);   // exception: null check operator used on null value because string is null.

  // What happens under the hood using ! operator? !. converts datatype? to datatype so that its length can be read at compile time but as xyz is still null then we got exception.

  // So, alternative to bang we use Null-aware, Null-coalescing 

  // 2. Null coalescing ??
  String? person;
  // Instead of: String nonNull = name!; (Crashes if null)
  String nonNull = person ?? "Guest";
  print(nonNull);

  String? x = null;
  // x = "x";~
  print(x?.length);
  int asdf;
  print(asdf)
}