import 'package:flutter/material.dart';
import 'package:qr_code_scanner/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,git push -u origin master
      title: 'QR Code Scanner',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.amber[900],
        fontFamily: 'OpenSans',
      ),
    );
  }
}
