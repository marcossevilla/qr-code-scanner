import 'package:flutter/material.dart';
import 'package:qr_code_scanner/src/models/scan_model.dart';

class ViewMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Coordinates',
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text('${scanModel.value}'),
      ),
    );
  }
}
