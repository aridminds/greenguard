import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewPlantSheetViewmodel extends BaseViewModel {
  TextEditingController plantNameController = TextEditingController();
  TextEditingController plantDescriptionController = TextEditingController();

  void addPlant(BuildContext context) {
    Navigator.of(context).pop();
  }
}