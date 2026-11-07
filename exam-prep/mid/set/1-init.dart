void main() {
  var a = {1, 2, 3}, b = {2, 3, 4};

  print(a.union(b));            // {1, 2, 3, 4}

  a.intersection(b);            // {2, 3}

  a.difference(b);              // {1}

  print(a.length);              // 3
}