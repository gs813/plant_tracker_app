import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/plant.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await _initDB('plants.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {

    await db.execute('''
CREATE TABLE plants(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
type TEXT,
watering TEXT,
note TEXT
)
''');
  }

  Future<int> insertPlant(Plant plant) async {
    final db = await instance.database;
    return db.insert('plants', plant.toMap());
  }

  Future<List<Plant>> getPlants() async {

    final db = await instance.database;
    final result = await db.query('plants');

    return result.map((e) => Plant.fromMap(e)).toList();
  }

  Future<int> deletePlant(int id) async {

    final db = await instance.database;

    return db.delete(
      'plants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updatePlant(Plant plant) async {

    final db = await instance.database;

    return db.update(
      'plants',
      plant.toMap(),
      where: 'id = ?',
      whereArgs: [plant.id],
    );
  }
}