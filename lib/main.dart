import 'package:qr_code_scanner/src/pages/home_page.dart';
import 'package:qr_code_scanner/src/pages/view_map.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code Scanner',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'map': (BuildContext context) => ViewMapPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.greenAccent[700],
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'OpenSans',
            color: Colors.white,
          ),
          body1: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
