import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// UserProvider class to manage database operations
class UserProvider {
  Database? _database;

  // Initialize database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Create and open the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'users4.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create tables in the database
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  // Fetch all users from the database
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }
}
