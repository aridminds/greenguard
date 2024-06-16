import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/app/app.router.dart';
import 'package:greenguard/models/plant.dart';
import 'package:greenguard/services/database_helper.dart';
import 'package:greenguard/services/plant_service.dart';
import 'package:greenguard/ui/views/plants/new_plant_bluetooth_sheet.dart';
import 'package:greenguard/ui/views/plants/new_plant_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PlantsViewModel extends BaseViewModel {
  final _plantService = locator<PlantService>();
  final _databaseHelper = locator<DatabaseHelper>();
  final _navigationService = locator<NavigationService>();

  var plants = <Plant>[];

  Future<void> initialize(BuildContext context) async {
    plants = await _plantService.getPlants();

    notifyListeners();
  }

  Future<void> refreshPlants() async {
    plants = await _plantService.getPlants();
    notifyListeners();
  }

  void tapPlant(Plant plant) {
    _navigationService.navigateToPlantDetailView(plant: plant);
  }

  void longPressPlant(Plant plant) {
    _databaseHelper.deletePlant(plant);
    plants.remove(plant);
    notifyListeners();
  }

  Future<void> showNewPlantSheet(BuildContext parentContext, {bool isBluetooth = false}) {
    return showModalBottomSheet(
      context: parentContext,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) => isBluetooth ? NewPlantBluetoothSheet(onPlantAdded: refreshPlants) : NewPlantSheet(onPlantAdded: refreshPlants),
    );
  }
}
