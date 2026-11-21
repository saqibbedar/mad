class UserProfile {
  // deferred initialization: declared now, assigned later
  late String username;

  set bootUser(String username) {
    this.username = username;
  }
}

void main() {
  var user = UserProfile();

  // assign value before reading it
  user.bootUser = "saqibbedar";
  print(user.username);       // saqibbedar
}
