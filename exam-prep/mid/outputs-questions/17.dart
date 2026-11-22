// generic typing
class Box<T> {
  T value;
  Box(this.value);
}

void main() {
  var intBox = Box<int>(10); // Box(10) direct
  var floatBox = Box(10.0); // Box<double>(10.0)

  print(intBox); // Instance of 'Box<int>' 
  print(intBox.value); // 10

  print(floatBox); // Instance of 'Box<double>'
  print(floatBox.value); // 10.0
}
