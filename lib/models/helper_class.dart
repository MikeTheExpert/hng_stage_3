import 'package:hng_stage_3/models/wallpaper_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('wallpapers.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    // Initialize FFI
    sqfliteFfiInit();

    // Get path for database
    final dbPath = await databaseFactoryFfi.getDatabasesPath();
    final path = join(dbPath, fileName);

    return await databaseFactoryFfi.openDatabase(path, options: OpenDatabaseOptions(
      version: 1,
      onCreate: _createDB,
    ));
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE wallpapers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        filePath TEXT NOT NULL,
        category TEXT NOT NULL
      )
    ''');
  }

  // Insert
  Future<int> insertWallpaper(Wallpaper wallpaper) async {
    final db = await instance.database;
    return await db.insert('wallpapers', wallpaper.toMap());
  }

  // Query all
  Future<List<Wallpaper>> getWallpapers() async {
    final db = await instance.database;
    final result = await db.query('wallpapers');
    return result.map((map) => Wallpaper.fromMap(map)).toList();
  }

  // Delete
  Future<int> deleteWallpaper(int id) async {
    final db = await instance.database;
    return await db.delete('wallpapers', where: 'id = ?', whereArgs: [id]);
  }

  // Close
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
