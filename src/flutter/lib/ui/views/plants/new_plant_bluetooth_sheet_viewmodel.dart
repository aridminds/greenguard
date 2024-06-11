import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/services/ble_service.dart';
import 'package:greenguard/services/bthome/bthome.dart';
import 'package:greenguard/services/database_helper.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewPlantBluetoothSheetViewmodel extends BaseViewModel {
  NewPlantBluetoothSheetViewmodel({this.onPlantAdded});

  final _navigationService = locator<NavigationService>();
  final _databaseHelper = locator<DatabaseHelper>();
  final _bleService = locator<BleService>();

  final Function? onPlantAdded;

  StreamSubscription<List<ScanResult>>? _scanSubscription;
  List<ScanResult> _scanResults = [];

  Future<void> initialize(BuildContext context) async {
    _scanSubscription = _bleService.scanResults.listen((List<ScanResult> results) {
      _scanResults = results;
      notifyListeners();
    });

    _bleService.startScanning(timeout: 20);
  }

  List<Widget> buildPlantDeviceList() {
    if (_scanResults.isEmpty) {
      return [
        const ListTile(
          title: Text('Keine BTHome Geräte gefunden'),
        ),
      ];
    }

    var bthomeSensor = BTHomeSensor();

    return _scanResults
        .map((r) => InkWell(
            child: ListTile(
              leading: const Icon(Symbols.settings_remote),
              title: Text("${r.device.platformName} (${bthomeSensor.parseBTHomeV2(r.advertisementData.serviceData.entries.first.value).first.data.toString()})"),
              subtitle: Text(r.device.remoteId.toString()),
            ),
            onTap: () async => await addPlant(r.device.platformName, remoteId: r.device.remoteId.toString())))
        .toList();
  }

  Future<void> addPlant(String name, {String? remoteId}) async {
    await _databaseHelper.insertPlant(name, remoteId, remoteId: remoteId);

    if (onPlantAdded != null) {
      onPlantAdded!();
    }

    _navigationService.back();
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    super.dispose();
  }
}
