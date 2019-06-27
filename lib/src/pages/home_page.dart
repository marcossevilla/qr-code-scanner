import 'package:qr_code_scanner/src/pages/directions_page.dart';
import 'package:qr_code_scanner/src/pages/maps_page.dart';

import 'package:qr_code_scanner/src/providers/db_provider.dart';

import 'package:qrcode_reader/qrcode_reader.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: _loadPage(currentIndex),
      bottomNavigationBar: _createBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
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

  _scanQR() async {
    // test values
    // geo:40.782490097914604,-73.97160902460939

    String futureString = 'https://google.com';

    // try {
    //   futureString = await QRCodeReader().scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }

    // print('futureString: $futureString');

    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      DBProvider.db.newScan(scan);
    }
  }
}
