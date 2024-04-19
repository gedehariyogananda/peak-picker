import 'package:flutter/material.dart';

class PinTitleWidget extends StatelessWidget {
  final String nameDescription;
  const PinTitleWidget({super.key, required this.nameDescription});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        nameDescription,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
