class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});

  Product.fromJson(Map<String, dynamic> json) : name = json['name'], price = (json['price'] as num).toDouble();

  // change default output of instance: Instance of 'Product' to Product(name: _____, price: _____)
  @override
  String toString() => "Product(name: $name, price: $price)";
}


void main() {
  var product = Product.fromJson({"name": "Laptop", "price": 999.99});
  print(product);
}