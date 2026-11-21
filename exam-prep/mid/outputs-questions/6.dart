Function name = () => "Hello, world";

// callbacks
void fn(Function cb) {
  // invoke callback
  print(cb());
}

void main() {
  print(name()); // Hello, world

  fn(() => "Hello, world");
}
