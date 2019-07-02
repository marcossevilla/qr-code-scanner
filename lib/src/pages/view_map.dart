import 'package:qr_code_scanner/src/models/scan_model.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:flutter/material.dart';

class ViewMapPage extends StatefulWidget {
  @override
  _ViewMapPageState createState() => _ViewMapPageState();
}

class _ViewMapPageState extends State<ViewMapPage> {
  final map = new MapController();

  String mapId = 'dark';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coordinates',
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () => map.move(scan.getLatLng(), 15.0),
          ),
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createFAB(context),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15.0,
      ),
      layers: [
        _createMap(),
        _createMarkers(scan),
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
        'id': 'mapbox.$mapId',
        // other id types: dark, light, outdoors, satellite
      },
    );
  }

  _createMarkers(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
        width: 100.0,
        height: 100.0,
        point: scan.getLatLng(),
        builder: (BuildContext context) => Container(
              child: Icon(
                Icons.location_on,
                size: 45.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
      ),
    ]);
  }

  _createFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (mapId == 'dark') {
          mapId = 'light';
        } else if (mapId == 'light') {
          mapId = 'outdoors';
        } else if (mapId == 'outdoors') {
          mapId = 'satellite';
        } else if (mapId == 'satellite') {
          mapId = 'streets';
        } else if (mapId == 'streets') {
          mapId = 'dark';
        }

        setState(() {});
      },
      child: Icon(Icons.refresh),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
