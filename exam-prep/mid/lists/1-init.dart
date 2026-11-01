// automatically dart will infer type of List<String> or for mixed List<Object>
List fruits = ["Apple", "Banana"];
List mixed = ["Apple", 1, 2];

List<String>? lst = [];

void addToList(){
  // lst.add("x"); // potentially null error: so use ?.
  for(var i = 0; i<5; i++) {
    lst?.add("$i");
  }
  print(lst);
}

void main() {
  addToList();
  print(fruits);
  print(mixed);
}