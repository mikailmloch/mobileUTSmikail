import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:iotuts/ProfilePage.dart';
import 'package:iotuts/bmi_screen.dart';
import 'package:iotuts/calculator_screen.dart';
import 'package:iotuts/home_screen.dart';
import 'package:iotuts/list_halaman.dart';
import 'package:iotuts/nilai_screen.dart';
import 'package:iotuts/suhu_screen.dart';
import 'package:iotuts/uang_screen.dart';
import 'package:iotuts/panjang_screen.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ListHalaman(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent, //atau white 24
        color: Colors.grey.shade800,
        items: <Widget>[
          Icon(Icons.home, color: Colors.white, size: 30),
          Icon(Icons.list, color: Colors.white, size: 30),
          Icon(Icons.person, color: Colors.white, size: 30),
        ],
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
