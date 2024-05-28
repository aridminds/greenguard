import 'dart:io';

import 'package:greenguard/db/plant_model.dart';
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
        image BLOB NULL
      )
    ''');
  }

  Future<int> insertPlant(String name, String description) async {
    return await _database.insert(
        'plants',
        {
          'name': name,
          'description': description,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deletePlant(PlantModel plant) async {
    await _database.delete(
      'plants',
      where: 'id = ?',
      whereArgs: [plant.id],
    );
  }

  Future<List<PlantModel>> getPlants() async {
    final List<Map<String, dynamic>> plants = await _database.query('plants');

    return List.generate(plants.length, (i) {
      return PlantModel(
        id: plants[i]['id'],
        name: plants[i]['name'],
        description: plants[i]['description'],
        image: plants[i]['image'],
      );
    });
  }
}
