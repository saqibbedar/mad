// Named arguments: matched by label, order doesn't matter
// args are enclosed with {}
// and from invoke side called as func(arg1: val, arg2: val)

// This function will cause compile-time-error: potentially null
// void logger({String msg, int line}){
//   print("$line: $msg");
// }

// There are three solution for it

// Solution 1: using required keyword so argument is always passed when function is invoked
void logger1({required String msg, required int line}) {
  print("$line: $msg");
}

// Solution 2: make types nullable
void logger2({String? msg, int? line}) {
  print("$line: $msg");
}

// Solution 3: provide a default fallback value
void logger3({String msg = "info", int line = 0}) {
  print("$line: $msg");
}

void main() {
  // named args matched by labels
  logger1(line: 10, msg: 'A bug!');
}
