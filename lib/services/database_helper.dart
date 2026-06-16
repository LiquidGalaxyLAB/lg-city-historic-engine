import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/lugares.dart';

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
          CREATE TABLE llocs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            categoria TEXT NOT NULL,
            nom TEXT NOT NULL,
            latitud REAL NOT NULL,
            longitud REAL NOT NULL,
            altitud REAL NOT NULL,
            heading REAL NOT NULL,
            tilt REAL NOT NULL,
            range REAL NOT NULL,
            altitude_mode TEXT NOT NULL,
            epoca TEXT NOT NULL,
            fecha_inici TEXT,
            fecha_fi TEXT,
            descripcio_ca TEXT NOT NULL,
            descripcio_es TEXT NOT NULL,
            descripcio_en TEXT NOT NULL
          )
        ''');
        await _insertarDades(db);
      },
    );
  }

  Future<List<Lloc>> getLlocsByCategoria(String categoria) async {
    final db = await database;
    final maps = await db.query(
      'llocs',
      where: 'categoria = ?',
      whereArgs: [categoria],
    );
    return maps.map((m) => Lloc.fromMap(m)).toList();
  }

  Future<List<Lloc>> getAllLlocs() async {
    final db = await database;
    final maps = await db.query('llocs');
    return maps.map((m) => Lloc.fromMap(m)).toList();
  }
}