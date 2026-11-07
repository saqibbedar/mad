// Positional parameters (order matters): args must be supplied in the exact declared order
void log(String msg, int line) {
  print("$line: $msg");
}

// dart don't support default value on plain parameters instead use {String msg="info", int line=0} to achieve it.
// void log2(String msg="info", int line=0) {}  // this will cause error

void main () {
  // args passed in the same order as they are declared
  log('A bug!', 55);
}