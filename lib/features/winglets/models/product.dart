class Product {
  final int id;
  final String name;
  final int quantity;

  const Product({
    required this.id,
    required this.name,
    required this.quantity,
  });

  Product copyWith({
    int? id,
    String? name,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }
}
