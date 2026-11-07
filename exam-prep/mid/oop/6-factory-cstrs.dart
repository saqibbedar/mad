// view handwritten notes
class Logger{
  static Logger? _instance;

  Logger._internal();

  factory Logger() {
    return _instance ??= Logger._internal();
  }
}

void main() {
  var a = Logger();
  var b = Logger();
  print(identical(a, b));
}