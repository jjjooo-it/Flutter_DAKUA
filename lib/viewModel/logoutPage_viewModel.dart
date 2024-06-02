import 'package:sqflite/sqflite.dart';
import '../dbHelper/user_dbHelper.dart';

class LogoutViewModel {
  final DBHelper _dbHelper = DBHelper();

  Future<void> logout() async {
    final db = await DBHelper.getDB();
    await db.delete('users');
  }
}
