import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/db/database_helper.dart';
import 'package:stacked/stacked.dart';

class NewPlantSheetViewmodel extends BaseViewModel {
  final plantNameController = TextEditingController();
  final plantDescriptionController = TextEditingController();
  final _databaseHelper = locator<DatabaseHelper>();

  var newPlantButtonEnabled = false;

  Future<void> initialize(BuildContext context) async {
    plantNameController.addListener(() {
      if (plantNameController.text.isNotEmpty) {
        newPlantButtonEnabled = true;
      } else {
        newPlantButtonEnabled = false;
      }

      notifyListeners();
    });
  }

  Future<void> addPlant(BuildContext context) async {
    await _databaseHelper.insertPlant(
        plantNameController.text, plantDescriptionController.text);
  }
}
