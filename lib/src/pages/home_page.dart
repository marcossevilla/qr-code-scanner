import 'package:qr_code_scanner/src/bloc/scan_bloc.dart';
import 'package:qr_code_scanner/src/models/scan_model.dart';
import 'package:qr_code_scanner/src/pages/directions_page.dart';
import 'package:qr_code_scanner/src/pages/maps_page.dart';

import 'package:qr_code_scanner/src/utils/utils.dart' as utils;

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scanBloc = new ScanBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Code Scanner',
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.black,
            ),
            onPressed: scanBloc.deleteAll,
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
    // some test values
    // geo:40.782490097914604,-73.97160902460939

    String futureString = 'https://google.com';

    // try {
    //   futureString = await QRCodeReader().scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }

    print('futureString: $futureString');

    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      scanBloc.addScan(scan);

      final scan2 = ScanModel(
        value: 'geo:40.71174275262298,-73.99358168085939',
      );
      scanBloc.addScan(scan2);
    }
  }
}
