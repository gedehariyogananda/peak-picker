class PurchasedHistory {
  final String id;
  final String productId;
  final String nameProduct;
  final String imageProduct;
  final String startBorrowPurchased;
  final String endBorrowPurchased;
  final String resultPricePurchased;
  final String statusPurchased;
  final String attemptPurchased;

  PurchasedHistory({
    required this.id,
    required this.productId,
    required this.nameProduct,
    required this.imageProduct,
    required this.startBorrowPurchased,
    required this.endBorrowPurchased,
    required this.resultPricePurchased,
    required this.statusPurchased,
    required this.attemptPurchased,
  });

  factory PurchasedHistory.fromJson(Map<String, dynamic> json) {
    return PurchasedHistory(
      id: json['id'].toString(),
      productId: json['product_id'].toString(),
      nameProduct: json['name_product'],
      imageProduct: json['image_product'],
      startBorrowPurchased: json['start_borrow_purchased'],
      endBorrowPurchased: json['end_borrow_purchased'],
      resultPricePurchased: json['result_price_purchased'].toString(),
      statusPurchased: json['status_purchased'],
      attemptPurchased: json['attemp_purchased'],
    );
  }

  get data => null;
}
