// List initialization methods
void main() {
  // 1
  List<String> lst = [];
  lst.add("Item1");
  lst.add("Item2");
  print(lst); // [Item1, Item2]

  // 2
  List<String>? lst2 = [];
  lst2.add("Item1");
  lst2.add("Item2");
  print(lst2); // [Item1, Item2]

  // 3
  List<String>? lst3 = []
    ..add("Item1")
    ..add("Item2");
  print(lst3); // [Item1, Item2]

  var cart = <String>[]
    ..add('Pencil')
    ..add('Eraser');

  print(cart); // [Pencil, Eraser]

  List<String> cartX = []
    ..add("Item1")
    ..add("Item2");
  print(cartX); // [Item1, Item2]

  List<String>? nullCheckList;
  nullCheckList?..add('Pen');
  print(nullCheckList); // null because list object was so ?.. returned null

  List<String> nullCheckList2;
  nullCheckList2?..add('Pencil');
  print(nullCheckList2);
}
