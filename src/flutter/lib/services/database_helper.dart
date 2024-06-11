import 'dart:io';
import 'package:greenguard/models/plant.dart';
import 'package:greenguard/models/sensor_data.dart';
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
    ''');

    await db.execute('''
      CREATE TABLE sensor_data(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        plant_id INTEGER,
        temperature REAL DEFAULT NULL,
        humidity REAL DEFAULT NULL,
        soil_moisture REAL DEFAULT NULL,
        light_intensity REAL DEFAULT NULL,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
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

    var sensorData = await getLatestSensorDataForPlant(id);
    return Plant.fromMap(plants[0]).copyWith(latestSensorData: sensorData);
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

    return Future.wait(plants.map((plant) async {
      var sensorData = await getLatestSensorDataForPlant(plant['id']);
      return Plant.fromMap(plant).copyWith(latestSensorData: sensorData);
    }));
  }

  Future<List<Plant>> getPlantFilteredWhere(String where, List<dynamic> whereArgs) async {
    final List<Map<String, dynamic>> plants = await _database.query(
      'plants',
      where: where,
      whereArgs: whereArgs,
    );

    return Future.wait(plants.map((plant) async {
      var sensorData = await getLatestSensorDataForPlant(plant['id']);
      return Plant.fromMap(plant).copyWith(latestSensorData: sensorData);
    }));
  }

  Future<void> insertSensorData(SensorData sensorData) async {
    await _database.insert(
      'sensor_data',
      sensorData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<SensorData?> getLatestSensorDataForPlant(int plantId) async {
    final List<Map<String, dynamic>> sensorData = await _database.query(
      'sensor_data',
      where: 'plant_id = ?',
      whereArgs: [plantId],
      orderBy: 'created_at DESC',
      limit: 1,
    );

    if (sensorData.isEmpty) {
      return null;
    }

    return SensorData.fromMap(sensorData[0]);
  }

  Future<List<SensorData>?> getSensorDataForPlant(int plantId) async {
    final List<Map<String, dynamic>> sensorData = await _database.query(
      'sensor_data',
      where: 'plant_id = ?',
      whereArgs: [plantId],
    );

    if (sensorData.isEmpty) {
      return null;
    }

    return List.generate(sensorData.length, (i) {
      return SensorData.fromMap(sensorData[i]);
    });
  }
}
