class Product {
  final String name;
  final double price;
  final String category;
  int quantity;

  Product({
    required this.name,
    required this.price,
    required this.category,
    this.quantity = 0,
  });

  /// Factory constructor to initialize from raw Map data
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      category: map['category'] as String,
      quantity: 0,
    );
  }
}
