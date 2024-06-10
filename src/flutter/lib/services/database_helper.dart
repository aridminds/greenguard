import 'dart:io';
import 'package:greenguard/models/plant.dart';
import 'package:greenguard/models/watering_need.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database _database;

  Future initialize() async {
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
        remote_id TEXT DEFAULT NULL,
        watering_interval INTEGER DEFAULT 7,
        watering_need INTEGER DEFAULT 0
      );
      
      CREATE TABLE sensor_data(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        plant_id INTEGER,
        temperature REAL,
        humidity REAL,
        light_intensity REAL,
        FOREIGN KEY(plant_id) REFERENCES plants(id)
          ON DELETE CASCADE
          ON UPDATE CASCADE
      );
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
      remoteId: plants[0]['remote_id'],
      wateringInterval: plants[0]['watering_interval'],
      lastWatered: plants[0]['last_watered'],
      wateringNeed: WateringNeed.values[plants[0]['watering_need']],
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

  Future<int> insertPlant(String name, String? description, {String? remoteId}) async {
    return await _database.insert(
        'plants',
        {
          'name': name,
          'description': description,
          'remote_id': remoteId,
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
        remoteId: plants[i]['remote_id'],
        wateringInterval: plants[i]['watering_interval'],
        lastWatered: plants[i]['last_watered'],
        wateringNeed: WateringNeed.values[plants[i]['watering_need']],
      );
    });
  }

  Future<List<Plant>> getPlantFilteredWhere(String where, List<dynamic> whereArgs) async {
    final List<Map<String, dynamic>> plants = await _database.query(
      'plants',
      where: where,
      whereArgs: whereArgs,
    );

    return List.generate(plants.length, (i) {
      return Plant(
        id: plants[i]['id'],
        name: plants[i]['name'],
        description: plants[i]['description'],
        remoteId: plants[i]['remote_id'],
        wateringInterval: plants[i]['watering_interval'],
        lastWatered: plants[i]['last_watered'],
        wateringNeed: WateringNeed.values[plants[i]['watering_need']],
      );
    });
  }
}
