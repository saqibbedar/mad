// no parameter 
void greet() {
  print("Hello!");
}

// parameter
void printSum(int a, int b) {
  print(a+b);
}

// arrow func
int square(int x) => x^2;


// anonyms 
var names = ['Alice', 'Bob', 'Charlie'];
void func() {
  names.forEach((name) => print(name));
}

void main() {
  func();
}