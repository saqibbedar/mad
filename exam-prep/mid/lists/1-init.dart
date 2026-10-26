// automatically dart will infer type of List<String> or for mixed List<Object>
List fruits = ["Apple", "Banana"];
List mixed = ["Apple", 1, 2];

void main() {
  print(fruits);
  print(mixed);
}