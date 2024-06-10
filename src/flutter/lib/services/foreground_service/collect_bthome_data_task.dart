import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/services/ble_service.dart';

class CollectBthomeDataTask {
  final _bleService = locator<BleService>();

  late List<ScanResult> _scanResults = <ScanResult>[];

  Future collectData() async {
    var scanSubscription = _bleService.scanResults.listen((List<ScanResult> results) {
      _scanResults = results;
    });

    _bleService.startScanning(timeout: 5);

    await Future.delayed(const Duration(seconds: 5));

    scanSubscription.cancel();
  }
}
