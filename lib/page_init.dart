import 'package:flutter/material.dart';
import 'package:peak_packer/pages/faq_page.dart';
import 'package:peak_packer/pages/favorite_page.dart';
import 'package:peak_packer/pages/history_page.dart';
import 'package:peak_packer/pages/home_page.dart';
import 'package:peak_packer/uttils/colors.uttils.dart';

class PageInit extends StatefulWidget {
  const PageInit({Key? key}) : super(key: key);

  @override
  _PageInitState createState() => _PageInitState();
}

class _PageInitState extends State<PageInit> {
  int _selectedIndex = 0;

  void setSelectedNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pagesRoute = [
    const HomePage(),
    const FavoritePage(),
    const HistoryPage(),
    const FaqPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagesRoute[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border_outlined,
            ),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_invoke_rounded),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer_outlined),
            label: 'FAQ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colors.hijau,
        unselectedItemColor: colors.abu,
        onTap: setSelectedNav,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
