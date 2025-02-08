import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseProvider {
  Future<Database> get database;

  Future<void> close();
}

class DatabaseProviderImpl implements DatabaseProvider {
  static DatabaseProviderImpl? _instance;

  Database? _database;

  DatabaseProviderImpl._();

  factory DatabaseProviderImpl() {
    _instance ??= DatabaseProviderImpl._();
    return _instance!;
  }

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final fullPath = join(dbPath, path);
    return await openDatabase(
      fullPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        isCompleted INTEGER NOT NULL
      )
    ''');
  }

  @override
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
