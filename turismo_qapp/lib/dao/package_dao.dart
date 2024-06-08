import 'package:sqflite/sqlite_api.dart';
import 'package:turismo_qapp/database/app_database.dart';
import 'package:turismo_qapp/models/package.dart';

class PackageDao {
  insert(Package package) async {
    Database database = await AppDatabase().openDB();
    await database.insert(AppDatabase().tableName, package.toMap());
  }

  delete(Package package) async {
    Database database = await AppDatabase().openDB();
    await database.delete(AppDatabase().tableName, where: 'id = ?', whereArgs: [package.id]);
  }

  Future<List<Package>> getAll() async {
    Database database = await AppDatabase().openDB();
    List<Map<String, dynamic>> result = await database.query(AppDatabase().tableName);
    List<Package> packages = result.map((e) => Package.fromJson(e)).toList();
    return packages;
  }

  Future<bool> isFavorite(Package package) async {
    Database database = await AppDatabase().openDB();
    List<Map<String, dynamic>> result = await database.query(AppDatabase().tableName, where: 'id = ?', whereArgs: [package.id]);
    return result.isNotEmpty;
  }
}