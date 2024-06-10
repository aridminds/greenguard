import 'dart:async';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleService {
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;
  late StreamSubscription<BluetoothAdapterState> _adapterStateSubscription;
  final StreamController<List<ScanResult>> _scanResultsController = StreamController<List<ScanResult>>.broadcast();

  Stream<List<ScanResult>> get scanResults => _scanResultsController.stream;
  bool _isScanning = false;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    if (await FlutterBluePlus.isSupported == false) {
      return;
    }

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    _adapterStateSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        // TODO ???
      } else {
        // TODO show error
      }
    });

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
      var filteredResults = results.where((r) => r.advertisementData.serviceData.keys.contains(Guid("fcd2"))).toList();
      _scanResultsController.add(filteredResults);
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((bool state) {
      _isScanning = state;
    });

    _isInitialized = true;
  }

  Future startScanning({required int timeout}) async {
    // if (_isScanning) {
    //   return;
    // }

    await FlutterBluePlus.startScan(timeout: Duration(seconds: timeout));
  }

  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    _adapterStateSubscription.cancel();
  }
}
