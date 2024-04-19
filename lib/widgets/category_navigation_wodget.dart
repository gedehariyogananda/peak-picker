import 'package:flutter/material.dart';

class CategoryNavigation extends StatelessWidget {
  final String category;

  const CategoryNavigation({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 153, 4),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Text(
          category,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
