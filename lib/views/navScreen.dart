import 'package:flutter/material.dart';
import 'package:mental_healthapp/views/consultscreen.dart';
import 'package:mental_healthapp/views/home.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currIndex = 0;
  final tabs = [
    HomeScreen(),
    ConsultScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currIndex,
          iconSize: 30,
          onTap: (value) {
            setState(() {
              _currIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.blue[800],
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.extension_rounded,
                  color: Colors.blue[800],
                ),
                label: 'Addon'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.email,
                  color: Colors.blue[800],
                ),
                label: 'Mails'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.blue[800],
                ),
                label: 'Profile')
          ]),
      body: tabs[_currIndex],
    );
  }
}
