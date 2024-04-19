import 'package:flutter/material.dart';

class DescriptionProduct extends StatelessWidget {
  final String nameDescription;
  final String description;
  const DescriptionProduct(
      {super.key, required this.nameDescription, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameDescription,
            style: const TextStyle(color: Colors.black, fontSize: 14.0),
          ),
          Text(
            description,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
