class Product {
  final String id;
  final String name_product;
  final String priceday_product;
  final String image_product;
  final String category_product;
  final String description_product;
  final String condition_product;
  final String created_at;

  Product({
    required this.id,
    required this.name_product,
    required this.priceday_product,
    required this.image_product,
    required this.category_product,
    required this.description_product,
    required this.condition_product,
    required this.created_at,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name_product: json['name_product'],
      priceday_product: json['priceday_product'],
      image_product: json['image_product'],
      category_product: json['category_product'],
      description_product: json['description_product'],
      condition_product: json['condition_product'],
      created_at: json['created_at'],
    );
  }
}
