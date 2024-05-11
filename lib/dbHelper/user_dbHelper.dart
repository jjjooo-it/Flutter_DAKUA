import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mobileplatform_project/model/user.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> getDB() async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  static initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, username TEXT, password TEXT, name TEXT, country TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertUser(User user) async {
    final db = await getDB();
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<User>> getUsers() async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
        name: maps[i]['name'],
        country: maps[i]['country'],
      );
    });
  }

  static Future<User?> getUserByUsernameAndPassword(
      String username, String password) async {
    final db = await getDB();
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (results.isNotEmpty) {
      return User.fromMap(results.first);
    } else {
      return null;
    }
  }
}
