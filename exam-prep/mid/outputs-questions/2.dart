void main() {
  String? s;
  String? x = null;
  print(s);               // null
  print(x);               // null
  print(x == s);          // true

  String y = '';
  print(y);               // blank (no output str length is zero y.length=>0)
}
