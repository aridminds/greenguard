import 'package:flutter/material.dart';
import 'package:greenguard/db/database.dart';
import 'package:greenguard/db/plant_model.dart';
import 'package:stacked/stacked.dart';

class NewPlantSheetViewmodel extends BaseViewModel {
  TextEditingController plantNameController = TextEditingController();
  TextEditingController plantDescriptionController = TextEditingController();

  Future<void> addPlant(BuildContext context) async {
    // Add plant to database
    final plantName = plantNameController.text;
    final plantDescription = plantDescriptionController.text;

    await Database.insertPlant(plantName, plantDescription);
  }
}
