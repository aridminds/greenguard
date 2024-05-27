import 'package:greenguard/db/plant_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class Database {
  static Future<sql.Database> initDatabase() async {
    return sql.openDatabase(
      join(await getDatabasesPath(), 'greenguard.db'),
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE plants(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        description TEXT,
        image BLOB NULL
      )
      """);
  }

  static Future<List<PlantModel>> getPlants() async {
    final db = await initDatabase();
    final List<Map<String, dynamic>> plants = await db.query('plants');

    return List.generate(plants.length, (i) {
      return PlantModel(
        id: plants[i]['id'],
        name: plants[i]['name'],
        description: plants[i]['description'],
        image: plants[i]['image'],
      );
    });
  }

  static Future<int> insertPlant(String name, String description) async {
    final db = await initDatabase();
    final id = await db.insert(
        'plants',
        {
          'name': name,
          'description': description,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }
}
