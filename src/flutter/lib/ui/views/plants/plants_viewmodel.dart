import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/models/plant.dart';
import 'package:greenguard/services/database_helper.dart';
import 'package:greenguard/ui/views/plants/new_plant_bluetooth_sheet.dart';
import 'package:greenguard/ui/views/plants/new_plant_sheet.dart';
import 'package:stacked/stacked.dart';

class PlantsViewModel extends BaseViewModel {
  final _databaseHelper = locator<DatabaseHelper>();

  Future<List<Plant>> getPlants() async {
    return _databaseHelper.getPlants();
  }

  void tapPlant(Plant plant) {
    // TODO: Implement plant detail view
  }

  void longPressPlant(Plant plant) {
    _databaseHelper.deletePlant(plant);
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
      builder: (context) => isBluetooth ? NewPlantBluetoothSheet(onPlantAdded: notifyListeners) : NewPlantSheet(onPlantAdded: notifyListeners),
    );
  }
}
