import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/lugares.dart';
import '../data/datos_lleida.dart';

/// Local SQLite copy of Lleida places (ca / es / en descriptions).
/// Used by [PoiLocalization], not as the list shown on screen.
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _db;

  DatabaseHelper._();

  Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'lleida.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE places (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT NOT NULL,
            name TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            altitude REAL NOT NULL,
            heading REAL NOT NULL,
            tilt REAL NOT NULL,
            range REAL NOT NULL,
            altitude_mode TEXT NOT NULL,
            era TEXT NOT NULL,
            start_date TEXT,
            end_date TEXT,
            description_ca TEXT NOT NULL,
            description_es TEXT NOT NULL,
            description_en TEXT NOT NULL
          )
        ''');
        await insertData(db);
      },
    );
  }

  Future<List<Place>> getPlacesByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      'Places',
      where: 'category = ?',
      whereArgs: [category],
    );
    return maps.map((m) => Place.fromMap(m)).toList();
  }

  Future<List<Place>> getAllPlaces() async {
    final db = await database;
    final maps = await db.query('places');
    return maps.map((m) => Place.fromMap(m)).toList();
  }
}
