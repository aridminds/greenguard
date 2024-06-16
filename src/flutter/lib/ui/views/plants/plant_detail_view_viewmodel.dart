import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/models/plant.dart';
import 'package:greenguard/services/plant_service.dart';
import 'package:stacked/stacked.dart';

class PlantDetailViewmodel extends BaseViewModel {
  final _plantService = locator<PlantService>();

  late List<(DateTime time, int data)> series = [];

  Future<void> initialize(BuildContext context, Plant plant) async {
    var sensorData = await _plantService.getSensorData(plant);

    if (sensorData == null) {
      series = [];
    } else {
      series = sensorData.map((e) => (e.createdAt, e.soilMoisture == null ? 0 : e.soilMoisture!.toInt())).toList();
    }

    notifyListeners();
  }
}
