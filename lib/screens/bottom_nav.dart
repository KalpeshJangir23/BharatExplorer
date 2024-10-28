import 'package:flutter/material.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/screens/HomeScreen/homeScreen.dart';
import 'package:trip_show_planner/screens/favourite/favourite.dart';
import 'package:trip_show_planner/screens/profile/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Track the index of the selected tab.
  int _selectedIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    const Home(),
    const FavScreen(),
    const ProfileScreen (),
  ];

  // Handle index changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Current index
        selectedItemColor: Appcolor.primary, // Selected item color
        unselectedItemColor: Colors.white, // Unselected item color
        onTap: _onItemTapped, // Handle tap
      ),
    );
  }
}
