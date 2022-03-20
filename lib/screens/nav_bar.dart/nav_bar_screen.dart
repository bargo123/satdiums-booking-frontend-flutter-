import 'package:flutter/material.dart';
import 'package:stdbook/screens/home_page.dart/home_page_screen.dart';
import 'package:stdbook/screens/login/login_screen.dart';
import 'package:stdbook/screens/reservations/reservarions_screen.dart';
import 'package:stdbook/screens/settings/settings_screen.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({Key key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[HomePage(), Reservations(), Settings()];

  void _onItemTapped(int index) {
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
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.sports_soccer), label: 'Home', backgroundColor: Colors.white),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Reservations', backgroundColor: Colors.yellow),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Colors.blue,
              ),
            ],
            backgroundColor: Color(0xff54c56d),
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor: Color(0xff0c3d27),
            iconSize: 25,
            onTap: _onItemTapped,
            elevation: 5),
      ),
    );
  }
}
