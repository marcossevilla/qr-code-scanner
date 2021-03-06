import 'package:qr_code_scanner/src/models/scan_model.dart';
import 'package:qr_code_scanner/src/providers/db_provider.dart';

import 'package:qr_code_scanner/src/bloc/validator.dart';

import 'dart:async';

class ScanBloc with Validators {
  static final ScanBloc _singleton = new ScanBloc._internal();

  factory ScanBloc() {
    return _singleton;
  }

  ScanBloc._internal() {
    //* get scans from db
    getScans();
  }

  final _scanController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scanStream =>
      _scanController.stream.transform(isGeo);
  Stream<List<ScanModel>> get scanStreamHttp =>
      _scanController.stream.transform(isHttp);

  dispose() {
    _scanController?.close();
  }

  /*
   *   methods to control information flow
   */

  getScans() async {
    _scanController.sink.add(await DBProvider.db.getAllScans());
  }

  addScan(ScanModel scan) async {
    await DBProvider.db.newScan(scan);
    getScans();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteAll() async {
    await DBProvider.db.deleteAll();
    getScans();
  }
}

final scanBloc = new ScanBloc();
