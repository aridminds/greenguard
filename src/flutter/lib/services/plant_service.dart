import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/models/plant.dart';
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

  Future<void> waterPlant(Plant plant) async {
    var newWateringNeed = plant.wateringNeed.index + 1;
    plant = plant.copyWith(wateringNeed: WateringNeed.values[newWateringNeed]);
    await _databaseHelper.updatePlant(plant);
  }
}
