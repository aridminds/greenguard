import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/services/bthome/bthome.dart';
import 'package:greenguard/services/database_helper.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewPlantBluetoothSheetViewmodel extends BaseViewModel {
  NewPlantBluetoothSheetViewmodel({this.onPlantAdded});

  final _navigationService = locator<NavigationService>();
  final _databaseHelper = locator<DatabaseHelper>();

  final Function? onPlantAdded;

  List<ScanResult> _scanResults = [];
  bool _isScanning = false;

  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;
  late StreamSubscription<BluetoothAdapterState> _adapterStateSubscription;

  Future<void> initialize(BuildContext context) async {
    if (await FlutterBluePlus.isSupported == false) {
      return;
    }

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    _adapterStateSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        _startScanning();
      } else {
        // TODO show error
      }
    });

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
      _scanResults = results;
      notifyListeners();
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((bool state) {
      _isScanning = state;
    });
  }

  Future _startScanning() async {
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 15),
      //withServiceData: [ServiceDataFilter(Guid("0000fcd2-0000-1000-8000-00805f9b34fb"))],
      withKeywords: ['greenguard'],
    );
  }

  List<Widget> buildPlantDeviceList() {
    if (_scanResults.isEmpty) {
      return [
        const ListTile(
          title: Text('No devices found'),
        ),
      ];
    }

    var bthomeSensor = BTHomeSensor();

    return _scanResults
        .map((r) => InkWell(
            child: ListTile(
              leading: const Icon(Symbols.settings_remote),
              title: Text(r.device.platformName),
              subtitle: Text(bthomeSensor.parseBTHomeV2(r.advertisementData.serviceData.entries.first.value).first.data.toString()),
            ),
            onTap: () async => await addPlant(r.device.platformName)))
        .toList();
  }

  Future<void> addPlant(String name) async {
    await _databaseHelper.insertPlant(name, 'BTHome', bthome: true);

    if (onPlantAdded != null) {
      onPlantAdded!();
    }

    _navigationService.back();
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    _adapterStateSubscription.cancel();

    super.dispose();
  }
}
