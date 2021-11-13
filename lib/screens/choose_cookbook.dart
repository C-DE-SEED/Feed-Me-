import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChooseCookbook extends StatefulWidget {
  const ChooseCookbook({Key key}) : super(key: key);

  @override
  _ChooseCookbookState createState() => _ChooseCookbookState();
}

class _ChooseCookbookState extends State<ChooseCookbook> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: size.height * 0.14,
        child: BottomNavigationBar(
          backgroundColor: Colors.black45,
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          selectedFontSize: size.width * 0.04,
          selectedIconTheme:
              IconThemeData(color: BasicGreen, size: size.width * 0.06),
          selectedItemColor: BasicGreen,
          selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: openSansFontFamily),
          unselectedIconTheme: IconThemeData(
            color: Colors.green,size: size.width * 0.05,
          ),
          unselectedItemColor: Colors.green,
          unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal, fontFamily: openSansFontFamily),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.user,
              ),
              label: 'Profil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: ' Kochbuch\nhinzufügen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Einstellungen',
            ),
          ],
        ),
      ),
      body: Center(
        child: _pages.elementAt(selectedIndex), //New
      ),
    );
  }

  static const List<Widget> _pages = <Widget>[
    Icon(
      FontAwesomeIcons.user,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.settings,
      size: 150,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
