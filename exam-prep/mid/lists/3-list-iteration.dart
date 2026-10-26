// traditional for loop
List<Map<dynamic, dynamic>> users = [];

// function
Map<dynamic, dynamic> make_user(int id) {
  return {
    "id": id + DateTime.now().microsecondsSinceEpoch,
    "username": "user$id",
    "name": "User $id",
    "age": 22,
    };
}

void main() {
  // traditional iteration
  for (int i=0; i<10; i++) {
    users.add(make_user(i));
  }

  // for-in 
  for (var u in users) {
    print(u);
  }

  // forEach
  users.forEach((u)=> print(u));
}
