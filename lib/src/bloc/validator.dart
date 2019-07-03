import 'dart:async';

import 'package:qr_code_scanner/src/providers/db_provider.dart';

class Validators {
  final isGeo =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where((scan) => scan.type == 'geo').toList();
      sink.add(geoScans);
    },
  );

  final isHttp =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where((scan) => scan.type == 'http').toList();
      sink.add(geoScans);
    },
  );
}
