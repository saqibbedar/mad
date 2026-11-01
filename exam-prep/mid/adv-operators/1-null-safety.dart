void main() {
  // nullable operator, string is non-nullable, it needs to be initialized, however, we can use datatype? (question mark attached to it) to make it nullable, hence no error and easily we can later assign any value 
  
  String? somestr;
  int? someint;
  Map? somemap;

  // but we can't call any method on nullable operator to do that we will use following methods:

  // Null-coalesce operator 
  var role = null;
  var user = role ?? "admin";  

  String? name;
  // Instead of: String nonNull = name!; (Crashes if null)
  String nonNull = name ?? "person";
  print(nonNull);

  print(user);
}