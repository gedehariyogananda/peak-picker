import 'package:flutter/material.dart';

class HistoryContent extends StatefulWidget {
  const HistoryContent({super.key});

  @override
  State<HistoryContent> createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 15),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "dawdawdaw",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text("tanggal "),
        ],
      ),
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Nama Product"),
                  Text("----"),
                ],
              ),
              Row(
                children: [
                  Text("Tanggal Pinjam"),
                  Text("----"),
                ],
              ),
              Row(
                children: [
                  Text("Tanggal Kembali"),
                  Text("----"),
                ],
              ),
              Row(
                children: [
                  Text("Result Harga"),
                  Text("----"),
                ],
              ),
            ],
          ),
        ),
      ],
      onExpansionChanged: (expanded) {
        setState(() {
          _expanded = expanded;
        });
      },
      trailing: _expanded
          // ignore: dead_code
          ? const Icon(Icons.arrow_drop_up)
          : const Icon(Icons.arrow_drop_down),
    );
  }
}
