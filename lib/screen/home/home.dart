import 'package:flutter/material.dart';
import 'package:personify_app/screen/Profile/profile.dart';
import 'package:personify_app/screen/report/reports.dart';
import 'package:personify_app/screen/report/viewreports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTab = 0;

  List _pages = [ViewReportPage(), AddReportPage(), Profile()];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "REPORTS"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "NEW"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
          ],
        ));
  }
}
