import 'package:flutter/material.dart';

class ImagesAnnounc extends StatelessWidget {
  const ImagesAnnounc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.blue,
        // image: DecorationImage(
        //   image: NetworkImage(
        //       'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
        //   fit: BoxFit.fitHeight,
        // ),
      ),
    );
  }
}
