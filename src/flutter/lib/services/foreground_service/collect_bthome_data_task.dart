import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/services/ble_service.dart';
import 'package:greenguard/services/bthome/bthome.dart';
import 'package:greenguard/services/plant_service.dart';

class CollectBthomeDataTask {
  Future collectData() async {
    var bleService = locator<BleService>();
    var plantService = locator<PlantService>();

    var scanResults = <ScanResult>[];

    var scanSubscription = bleService.scanResults.listen((List<ScanResult> results) {
      scanResults = results;
    });

    await bleService.startScanning(timeout: 5);
    await Future.delayed(const Duration(seconds: 5));

    scanSubscription.cancel();

    if (scanResults.isEmpty) {
      return;
    }

    var plantsWithSensors = await plantService.getPlantsWithBthomeSensor();

    if (plantsWithSensors.isEmpty) {
      return;
    }

    for (var plant in plantsWithSensors) {
      var sensorData = scanResults.firstWhere((element) => element.device.remoteId.toString() == plant.remoteId);

      var btHomeSensor = BTHomeSensor();
      var soilMoisture = btHomeSensor.parseBTHomeV2(sensorData.advertisementData.serviceData.entries.first.value).first.data;

      await plantService.updateSensorData(plant, soilMoisture: soilMoisture);
    }
  }
}
