void main() {
  // final can be assigned later but set once only  
  final x;
  x = "h";
  // x = "hello"; // error: can't be reassigned
  print(x);

  // const must be assigned a value on declaration
  const y;
  y = 10;
  print(y);
}
