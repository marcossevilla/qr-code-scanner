import 'package:flutter/material.dart';
import 'package:qr_code_scanner/src/pages/directions_page.dart';
import 'package:qr_code_scanner/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadPage(currentIndex),
      bottomNavigationBar: _createBottomNavBar(),
    );
  }

  Widget _loadPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return MapsPage();
      case 1:
        return DirectionsPage();
      default:
        return MapsPage();
    }
  }

  Widget _createBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => setState(() => currentIndex = index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.zoom_out_map),
          title: Text('Directions'),
        ),
      ],
    );
  }
}
