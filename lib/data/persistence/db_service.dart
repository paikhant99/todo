import 'dart:async';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data_constants.dart';

class SQLiteDatabaseService {
  /* 
    Comments - 
  */

  Database? _db;

  // (Get Database) : return the singleton instance of Factory constructor
  Future<Database> getDatabase() async {
    if (_db == null) {
      await open();
    }
    return _db!;
  }

  /*
    (Open) : Open a new database connection

    Comments - 
    If db does not exist, create a new db operating onCreate
    Else connect it
  */
  Future open() async {
    _db = await openDatabase(join(await getDatabasesPath(), dbName),
        onCreate: _onCreate, version: dbVersion);
  }

  // (Close) : Close database connection
  Future close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }

  // (On Create - Event) : Create tables and Add default values
  Future<void> _onCreate(Database db, int version) async{
    if (version >= 1) queriesV_1.forEach(db.execute);
  }

  // (Get Current Timestamp) : Retrieve the current timestamp in ISO Format
  String getCurrentTimestamp() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }
}
