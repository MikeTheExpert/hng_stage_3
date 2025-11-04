import 'package:hng_stage_3/models/settings_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class SettingsDatabaseHelper {
  static final SettingsDatabaseHelper instance = SettingsDatabaseHelper._init();
  factory SettingsDatabaseHelper() => instance;

  static Database? _database;
  SettingsDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('settings.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    sqfliteFfiInit();
    final dbPath = await databaseFactoryFfi.getDatabasesPath();
    final path = join(dbPath, fileName);

    return await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(version: 1, onCreate: _createDB),
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imageQuality TEXT NOT NULL,
        allowNotifications INTEGER NOT NULL,
        activated INTEGER NOT NULL,
        displayMode TEXT NOT NULL,
        autoRotation INTEGER NOT NULL,
        lockWallpaper INTEGER NOT NULL,
        syncAcrossDevices INTEGER NOT NULL
      )
    ''');
  }

  Future<void> saveSettings(SettingsModel settings) async {
    final dbClient = await database;
    await dbClient.insert(
      'settings',
      settings.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<SettingsModel?> getSettings() async {
    final dbClient = await database;
    final result = await dbClient.query('settings', limit: 1);
    if (result.isNotEmpty) {
      return SettingsModel.fromMap(result.first);
    }
    return null;
  }


  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
