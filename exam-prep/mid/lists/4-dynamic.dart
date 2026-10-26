// list of dynamic objects
List<Map<dynamic, dynamic>> lst = [];

void main() {
  lst.add({"key": "value"});
  lst.add({"key2": "value2"});

  lst.forEach((obj) => print(obj));
}