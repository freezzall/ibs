import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/pages/about.dart';
import 'package:ibsmobile/pages/home.dart';
import 'package:ibsmobile/pages/setting.dart';

import 'logout.dart';

class mainhomePage extends StatefulWidget {
  final String username;

  mainhomePage({required this.username});
  @override
  _mainhomePageState createState() => _mainhomePageState();
}

class _mainhomePageState extends State<mainhomePage> {
  int currentIndex = 0;
  final screens = [
    homePage(),
    aboutPage(),
    settingPage(),
    logoutPage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: screens[currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      iconSize: 30,
      selectedFontSize: 18,
      unselectedFontSize: 12,
      // showSelectedLabels: false,
      // showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: (index) => setState(() => currentIndex = index),
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Logout',
        ),
      ],
    ),
  );

}