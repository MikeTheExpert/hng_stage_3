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
      CREATE TABLE settings (
        imageQuality TEXT NOT NULL,
        allowNotifications INTEGER NOT NULL
      )
    ''');
  }

  // Insert user preference
  Future<int> insertSettings(SettingsModel settings) async {
    final db = await instance.database;
    await db.delete('settings'); // optional: clear old settings
    return await db.insert('settings', settings.toMap());
  }


  // Query settings choice
  Future<SettingsModel?> getSettings() async {
    final db = await instance.database;
    final result = await db.query('settings');
    if (result.isNotEmpty) {
      return SettingsModel.fromMap(result.first);
    }
    return null;
  }


  // Close
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
