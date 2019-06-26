import 'package:sqflite/sqflite.dart';

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

  initDB() async {}
}
