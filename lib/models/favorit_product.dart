class Favo {
  final String id;
  final String name_product;
  final String priceday_product;
  final String image_product;
  final String category_product;
  final String description_product;

  Favo({
    required this.id,
    required this.name_product,
    required this.priceday_product,
    required this.image_product,
    required this.category_product,
    required this.description_product,
  });

  factory Favo.fromJson(Map<String, dynamic> json) {
    return Favo(
      id: json['id'].toString(),
      name_product: json['name_product'],
      priceday_product: json['price/day_product'],
      image_product: json['image_product'],
      category_product: json['category_product'],
      description_product: json['description_product'],
    );
  }
}
