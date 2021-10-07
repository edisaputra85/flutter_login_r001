import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) _dbHelper = DbHelper._createObject();
    return _dbHelper;
  }

  //method untuk membuat database dan return objek database yang telah dibuat
  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db'; //path database
    //perintah untuk hapus database: await deleteDatabase(path);

    //method openDatabase akan create sebuah database dan menyimpannya pada path
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  //method call back _createDb
  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT NOT NULL UNIQUE,password TEXT NOT NULL,email TEXT NOT NULL UNIQUE)");
    await db.execute(
        "CREATE TABLE profiles (id INTEGER PRIMARY KEY AUTOINCREMENT,id_user INTEGER NOT NULL, fullname TEXT,phone TEXT,address TEXT)");
  }

  //method untuk mengecek apakah DB sudah ada? kalau belum create DB, selanjutnya dia return objek database
  Future<Database> getDatabase() async {
    if (_database == null) _database = await initDb();
    return _database;
  }
}
