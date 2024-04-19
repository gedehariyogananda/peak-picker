class TotalCheckout {
  final String totalPrice;

  TotalCheckout({required this.totalPrice});

  factory TotalCheckout.fromJson(Map<String, dynamic> json) {
    return TotalCheckout(
      totalPrice: json['data'],
    );
  }
}
