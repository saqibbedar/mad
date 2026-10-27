void main() {
  // nullable operator, string is non-nullable, it needs to be initialized, however, we can use datatype? (question mark attached to it) to make it nullable, hence no error and easily we can later assign any value 
  
  String? somestr;
  int? someint;
  Map? somemap;

  // but we can't call any method on nullable operator to do that we will use following methods:

  // null-aware operator ?. 
  var roles = {"role": "admin"};
  var user = roles["role"] ?? "admin";  


}