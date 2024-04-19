class Favorit {
  final int product_id;

  Favorit({
    required this.product_id,
  });

  factory Favorit.fromJson(Map<String, dynamic> json) {
    return Favorit(
      product_id: json['product_id'],
    );
  }
}
