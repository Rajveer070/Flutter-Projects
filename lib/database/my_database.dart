import 'package:sqflite/sqflite.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    var db = await openDatabase('exam.db', onCreate: (db, version) {
      db.execute(
          'CREATE TABLE Logindata(UserId INTEGER PRIMARY KEY AUTOINCREAMENT, email TEXT, password TEXT)');
    }, onUpgrade: (db, oldVersion, newVersion) {}, version: 1);
    return db;
  }

  Future<void> getDetails() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userlist = await db.rawQuery("Logindata");

    if (userlist.isNotEmpty) {
      print("Login successful");
    } else {
      print("No login");
    }
  }
}
