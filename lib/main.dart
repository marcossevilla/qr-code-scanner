import 'package:flutter/material.dart';
import 'package:qr_code_scanner/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code Scanner',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.greenAccent[700],
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'OpenSans',
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
