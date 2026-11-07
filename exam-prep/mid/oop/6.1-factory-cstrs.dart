// modern syntax
class Logger{
  static final Logger _instance = Logger._internal();
  Logger._internal();
  factory Logger() => _instance; 
}