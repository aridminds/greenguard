import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/models/plant.dart';
import 'package:greenguard/models/watering_need.dart';
import 'package:greenguard/services/plant_service.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _plantService = locator<PlantService>();

  var plantsWithWateringNeedsLow = <Plant>[];
  var plantsWithWateringNeedsMedium = <Plant>[];

  Future<void> initialize(BuildContext context) async {
    plantsWithWateringNeedsLow = await _plantService.getPlantsWithWateringNeeds(WateringNeed.low);
    plantsWithWateringNeedsMedium = await _plantService.getPlantsWithWateringNeeds(WateringNeed.medium);

    rebuildUi();
  }

  Future<void> refreshPlants({WateringNeed? wateringNeed}) async {
    if (wateringNeed == null) {
      plantsWithWateringNeedsLow = await _plantService.getPlantsWithWateringNeeds(WateringNeed.low);
      plantsWithWateringNeedsMedium = await _plantService.getPlantsWithWateringNeeds(WateringNeed.medium);
    } else {
      switch (wateringNeed) {
        case WateringNeed.low:
          plantsWithWateringNeedsLow = await _plantService.getPlantsWithWateringNeeds(wateringNeed);
          break;
        case WateringNeed.medium:
          plantsWithWateringNeedsMedium = await _plantService.getPlantsWithWateringNeeds(wateringNeed);
          break;
        case WateringNeed.high:
          break;
      }
    }
    rebuildUi();
  }

  Future<void> waterPlant(Plant plant) async {
    await _plantService.waterPlant(plant);
    await refreshPlants();
  }

  List<Widget> buildPlantDeviceList(List<Plant> plants) {
    if (plants.isEmpty) {
      return [
        const ListTile(
          title: Text('Keine Pflanzen vorhanden'),
        ),
      ];
    }

    return plants
        .map(
          (plant) => Card(
            child: InkWell(
              child: ListTile(
                leading: const Icon(Symbols.settings_remote),
                title: Text(plant.name),
                subtitle: Text(plant.description),
              ),
            ),
          ),
        )
        .toList();
  }
}
