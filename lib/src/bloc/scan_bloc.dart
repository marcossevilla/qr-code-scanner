import 'dart:async';

import 'package:qr_code_scanner/src/providers/db_provider.dart';

class ScanBloc {
  static final ScanBloc _singleton = new ScanBloc._internal();

  factory ScanBloc() {
    return _singleton;
  }

  ScanBloc._internal() {
    // get scans from db
  }

  final _scanController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scanStream => _scanController.stream;

  dispose() {
    _scanController?.close();
  }
}

final scanBloc = new ScanBloc();
