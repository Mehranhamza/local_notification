import 'package:path_provider/path_provider.dart';
import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';

class DbHelper {
  static late Database db;

  static Future<void> initDB() async {
    final dbPath = await getDatabasesPath();
    db = await openDatabase(join(dbPath, "reminders.db"),
        onCreate: (db, version) async {
      await db.execute('''
CREATE TABLE reminders(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title TEXT,
description TEXT,
isActive INTEGER,
reminderTime TEXT,
category TEXT
)
''');
    }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> getReminder() async {
    return db.query("reminders");
  }

  static Future<int> insertReminder(Map<String, dynamic> reminder) async {
    return await db.insert("reminders", reminder);
  }

  static Future<int> deleteReminder(int id) async {
    return await db.delete("reminders", where: "id = ?", whereArgs: [id]);
  }
}
