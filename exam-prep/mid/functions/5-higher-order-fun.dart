// A higher-order function takes a function as an argument, or return one (simple callback in js world)

void func(Function fn) {
  fn(); // invoke
}

void main() {
  func(()=>print("Higher order function"));
}