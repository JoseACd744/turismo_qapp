import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{
  final int version = 1;
  final String name = "turismo.db";
  final String tableName = "packages";
  Database? _db;

  Future<Database> openDB() async {
    _db ??= await openDatabase(join(await getDatabasesPath(), name),
      onCreate: (db, version) {
        String query = "CREATE TABLE $tableName (id TEXT PRIMARY KEY, name TEXT, description TEXT, image TEXT)";
        db.execute(query);
    },
    version: version
    );

    return _db as Database;

  }

  
}