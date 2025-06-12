import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    return await _initDB();
  }

  static Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'auth.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            phone TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<void> insertUser(String name, String phone) async {
    final db = await database;

    // Clear existing users before adding (1 user only)
    await db.delete('users');

    await db.insert('users', {'name': name, 'phone': phone});
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('users');

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  static Future<void> clearUser() async {
  final db = await database;
  await db.delete('users');
}

}
