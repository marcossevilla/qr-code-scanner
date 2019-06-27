import 'package:qr_code_scanner/src/models/scan_model.dart';
export 'package:qr_code_scanner/src/models/scan_model.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:io';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  //* this is a private constructor for DBProvider
  DBProvider._();

  /*
  *   db config methods
  */

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

  /*
  *   insert to db methods
  */

  //* scan object

  //* the raw way, don't use
  newRawScan(ScanModel newScan) async {
    final db = await database;

    final res = await db.rawInsert(
      "insert into Scans (id, type, value) "
      "values ( ${newScan.id}, '${newScan.type}', '${newScan.value}' )",
    );

    return res;
  }

  //* more secure way, use this one, it's cleaner
  newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    return res;
  }

  /*
  *   select from db methods
  */

  //* select specific register from Scans table
  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query(
      'Scans',
      where: 'id = ?',
      whereArgs: [id],
    );

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  //* select all registers from Scans table
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return list;
  }

  //* select registers with {type} filter
  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db.rawQuery("select * from Scans where type='$type'");

    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return list;
  }

  /*
  *   update to db methods
  */

  //* scan object

  //* specific scan update
  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update(
      'Scans',
      newScan.toJson(),
      where: 'id = ?',
      whereArgs: [newScan.id],
    );
    return res;
  }

  /*
  *   delete to db methods
  */

  //* scan object

  //* specific scan delete
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  //* all registers
  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('delete from Scans');
    return res;
  }
}
