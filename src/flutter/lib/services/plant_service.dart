import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/models/plant.dart';
import 'package:greenguard/models/sensor_data.dart';
import 'package:greenguard/models/watering_need.dart';
import 'package:greenguard/services/database_helper.dart';

class PlantService {
  final DatabaseHelper _databaseHelper = locator<DatabaseHelper>();

  Future<List<Plant>> getPlants() async {
    return await _databaseHelper.getPlants();
  }

  Future<List<Plant>> getPlantsWithWateringNeeds(WateringNeed wateringNeed) async {
    var plants = await _databaseHelper.getPlantFilteredWhere('watering_need = ?', [wateringNeed.index]);

    return plants;
  }

  Future<List<Plant>> getPlantsWithBthomeSensor() async {
    var plants = await _databaseHelper.getPlantFilteredWhere('remote_id IS NOT NULL', []);
    return plants;
  }

  Future<void> waterPlant(Plant plant) async {
    var newWateringNeed = plant.wateringNeed.index + 1;
    plant = plant.copyWith(wateringNeed: WateringNeed.values[newWateringNeed]);
    await _databaseHelper.updatePlant(plant);
  }

  Future<SensorData?> getLatestSensorData(Plant plant) async {
    return await _databaseHelper.getLatestSensorDataForPlant(plant.id);
  }

  Future<List<SensorData>?> getSensorData(Plant plant) async {
    return await _databaseHelper.getSensorDataForPlant(plant.id);
  }

  Future<void> updateSensorData(Plant plant, {double? temperature, double? humidity, double? soilMoisture, double? lightIntensity}) async {
    var sensorData = SensorData(id: 0, plantId: plant.id, temperature: temperature, humidity: humidity, soilMoisture: soilMoisture, lightIntensity: lightIntensity, createdAt: DateTime.now());

    await _databaseHelper.insertSensorData(sensorData);
  }
}
