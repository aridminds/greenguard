import 'dart:io';
import 'package:greenguard/models/plant.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database _database;

  Future initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'greenguard.db');
    _database = await sql.openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE plants(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        description TEXT,
        bthome INTEGER DEFAULT 0
      )
    ''');
  }

  Future<Plant> getPlant(int id) async {
    final List<Map<String, dynamic>> plants = await _database.query(
      'plants',
      where: 'id = ?',
      whereArgs: [id],
    );

    return Plant(
      id: plants[0]['id'],
      name: plants[0]['name'],
      description: plants[0]['description'],
      bthome: plants[0]['bthome'],
    );
  }

  Future<void> updatePlant(Plant plant) async {
    await _database.update(
      'plants',
      plant.toMap(),
      where: 'id = ?',
      whereArgs: [plant.id],
    );
  }

  Future<int> insertPlant(String name, String description, {bool bthome = false}) async {
    return await _database.insert(
        'plants',
        {
          'name': name,
          'description': description,
          'bthome': bthome ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deletePlant(Plant plant) async {
    await _database.delete(
      'plants',
      where: 'id = ?',
      whereArgs: [plant.id],
    );
  }

  Future<List<Plant>> getPlants() async {
    final List<Map<String, dynamic>> plants = await _database.query('plants');

    return List.generate(plants.length, (i) {
      return Plant(
        id: plants[i]['id'],
        name: plants[i]['name'],
        description: plants[i]['description'],
        bthome: plants[i]['bthome'] == 1,
      );
    });
  }

  Future<Plant> getPlantFilteredWhere(String where, List<dynamic> whereArgs) async {
    final List<Map<String, dynamic>> plants = await _database.query(
      'plants',
      where: where,
      whereArgs: whereArgs,
    );

    return Plant(
      id: plants[0]['id'],
      name: plants[0]['name'],
      description: plants[0]['description'],
      bthome: plants[0]['bthome'],
    );
  }
}
