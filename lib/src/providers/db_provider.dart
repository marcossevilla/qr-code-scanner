import 'package:qr_code_scanner/src/models/scan_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  // this is a private constructor for DBProvider
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    // if it doesn't exist

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory filesDirectory = await getApplicationDocumentsDirectory();

    final path = join(filesDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        'create table Scans ('
        ' id integer primary key,'
        ' type text,'
        ' value text'
        ')',
      );
    });
  }

  // the raw way, don't use
  newRawScan(ScanModel newScan) async {
    final db = await database;

    final res = await db.rawInsert(
      "insert into Scans (id, type, value) "
      "values ( ${newScan.id}, '${newScan.type}', '${newScan.value}' )",
    );

    return res;
  }

  // more secure way, use this one, it's cleaner
  newScan(ScanModel newScan) async {
    final db = await database;
    final res = db.insert('Scans', newScan.toJson());
    return res;
  }
}
