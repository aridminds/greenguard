import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/db/database_helper.dart';
import 'package:greenguard/db/plant_model.dart';
import 'package:greenguard/ui/views/plants/new_plant_sheet.dart';
import 'package:stacked/stacked.dart';

class PlantsViewModel extends BaseViewModel {
  final _databaseHelper = locator<DatabaseHelper>();

  Future<List<PlantModel>> getPlants() async {
    return _databaseHelper.getPlants();
  }

  void tapPlant(PlantModel plant) {
    // TODO: Implement plant detail view
  }

  void longPressPlant(PlantModel plant) {
    _databaseHelper.deletePlant(plant);
    notifyListeners();
  }

  Future<void> showNewPlantSheet(BuildContext parentContext) {
    return showModalBottomSheet(
      context: parentContext,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) => NewPlantSheet(onPlantAdded: notifyListeners),
    );
  }
}
