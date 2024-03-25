import 'package:sqflite/sqflite.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    var db = await openDatabase('matrimony.db', onCreate: (db, version) {
      db.execute(
          'CREATE TABLE Student(StuId INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
    }, onUpgrade: (db, oldVersion, newVersion) {}, version: 1);
    return db;
  }

  Future<int> insertUser(Map<String, Object?> map) async {
    Database db = await initDatabase();

    var res = await db.insert("Student", map);
    return res;
  }

  Future<int> editUser(Map<String, Object?> map, StuId) async {
    Database db = await initDatabase();

    var res =
        await db.update("Student", map, where: "StuId = ?", whereArgs: [StuId]);
    return res;
  }

  Future<List<Map<String, dynamic>>> getDetails() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userList = await db.query('Student');
    return userList;
  }

  Future<void> deleteUser(StuId) async {
    Database db = await initDatabase();
    var res =
        await db.delete('Student', where: 'StuId = ?', whereArgs: [StuId]);
  }
}
