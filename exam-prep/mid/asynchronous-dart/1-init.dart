Future<dynamic> fetchUser() async {
  await Future.delayed(Duration(seconds: 1));
  return [{"username": "saqibbedar", "lastlogin": "29-10-26"}];
}

void main() async {
  print(await fetchUser());
}