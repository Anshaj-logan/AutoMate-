import 'dart:io';
import 'package:auto_mate/core/models/vehicle_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


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
        // Create users table
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            phone TEXT NOT NULL
          )
        ''');

        // Create vehicles table
        await db.execute('''
          CREATE TABLE vehicles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            plateNumber TEXT NOT NULL,
            vin TEXT NOT NULL,
            brand TEXT NOT NULL,
            model TEXT NOT NULL,
            year INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // ------------------ User Table Methods ------------------

  static Future<void> insertUser(String name, String phone) async {
    final db = await database;
    await db.delete('users'); // Only one user allowed
    await db.insert('users', {'name': name, 'phone': phone});
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final result = await db.query('users');
    return result.isNotEmpty ? result.first : null;
  }

  static Future<void> clearUser() async {
    final db = await database;
    await db.delete('users');
  }

  // ------------------ Vehicle Table Methods ------------------

  static Future<void> insertVehicle(Vehicle vehicle) async {
    final db = await database;
    await db.insert('vehicles', vehicle.toMap());
  }

  static Future<List<Vehicle>> getAllVehicles() async {
    final db = await database;
    final result = await db.query('vehicles');

    return result.map((map) => Vehicle.fromMap(map)).toList();
  }

  static Future<void> clearVehicles() async {
    final db = await database;
    await db.delete('vehicles');
  }
}
