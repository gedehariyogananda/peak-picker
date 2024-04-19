import 'package:flutter/material.dart';
import 'package:peak_packer/models/product.dart';

class Cuy extends StatelessWidget {
  final List<Product> favorit;

  const Cuy({Key? key, required this.favorit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: ListView.builder(
        itemCount: favorit.length,
        itemBuilder: (context, index) {
          final product = favorit[index];
          return ListTile(
            title: Text(product.name_product),
            subtitle: Text(product.description_product),
            // Add more details as needed
          );
        },
      ),
      // Add more UI elements as needed
    );
  }
}
