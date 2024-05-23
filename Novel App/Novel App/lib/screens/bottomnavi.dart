import 'package:flutter/material.dart';
import 'package:semster_project/ads/bannerAd.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/screens/genres_screens.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/screens/library_screen.dart';
import 'package:semster_project/screens/me_screen.dart';
import 'package:semster_project/sevice/database.dart';

class BottomNavigation_Screen extends StatefulWidget {
  BottomNavigation_Screen({super.key, this.selectedIndex = 0});
  int selectedIndex;
  @override
  State<BottomNavigation_Screen> createState() =>
      _BottomNavigation_ScreenState();
}

class _BottomNavigation_ScreenState extends State<BottomNavigation_Screen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Library_Screen(),
    Genres_Screen(),
    Me_Screen()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
  }

  void _onItemTapped(int index) {
    if (index == 1) {}

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps_rounded),
              label: 'Genre',
            ),

            // BottomNavigationBarItem(
            //   icon: Icon(Icons.bookmark),
            //   label: 'Book Mark',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Me',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showUnselectedLabels: false,
        ));
  }
}
