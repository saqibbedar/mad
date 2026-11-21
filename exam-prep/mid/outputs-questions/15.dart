// Map in depth

void main() {
  var users = {'saqib': 22.5, 'mudasir': 30, 'muzamil': 40};

  // Access
  print(users['saqib']); // 22.5

  users['muzamil'] = 39;
  print(users['muzamil']); // 39

  print(users.containsKey('mudasir')); // true

  users.forEach((k, v) => print('$k: $v'));
}
