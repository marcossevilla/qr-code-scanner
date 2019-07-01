import 'package:qr_code_scanner/src/models/scan_model.dart';

import 'package:latlong/latlong.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:flutter/material.dart';

class ViewMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coordinates',
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {},
          ),
        ],
      ),
      body: _createFlutterMap(scanModel),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10.0,
      ),
      layers: [
        _createMap(),
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
          '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':
            'pk.eyJ1IjoibWFyY29zc2V2aWxsYSIsImEiOiJjanhqNnoyOGUwMG9hM25xZnIxdXY3ajlhIn0.lT8_4zgaY4FiOY2CiwfuQw',
        'id': 'mapbox.streets',
      },
    );
  }
}
