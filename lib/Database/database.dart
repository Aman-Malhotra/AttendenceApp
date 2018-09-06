import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseClient {
  Database _db;
  List yearsList = [];
  List classTempList = [];

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbpath = join(path.path, "database.db");
    _db = await openDatabase(dbpath, version: 1, onCreate: this._create);
  }

  Future deleteDb() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbpath = join(path.path, "database.db");
    await deleteDatabase(dbpath).whenComplete(() {
      print("Database deleted");
    });
  }

  Future _create(Database db, int version) async {
    await db.execute("""
    CREATE TABLE YearsTable(year TEXT)
    """);
  }

  Future addYears(String yearText) async {
    _db.rawInsert("INSERT INTO YearsTable(year) VALUES(?)", [
      yearText,
    ]);
    await _db.execute("""
    CREATE TABLE $yearText(classes TEXT)
    """);
    return 0;
  }

  Future getYears() async {
    // working
    _db.rawQuery("SELECT * FROM YearsTable").then((List l) {
      yearsList = [];
      for (Map m in l) {
        yearsList.add(m.values.elementAt(0));
//        print("List in dbClass = "+m.values.elementAt(0).toString());
      }
      return 0;
    });
  }

  Future removeYear(String yearText) async {
    _db.rawQuery("DROP TABLE $yearText");
    _db.rawDelete("DELETE FROM YearsTable WHERE year = ?",[yearText]);
  }
}
