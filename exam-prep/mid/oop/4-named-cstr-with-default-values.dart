// Name constructor with default values

class User{
  final String name;
  final bool isGuest;

  // default constructor 
  User(this.name) : isGuest = false;

  // Named constructor
  User.guest() : name = "Guest", isGuest = true;

  void show() {
    print("Name: $name, isGuest: $isGuest");
  }
}

void main() {
  var user_x = User("Saqib Bedar");
  var guest = User.guest();  
  print(guest.isGuest);
  print(guest.name);
}