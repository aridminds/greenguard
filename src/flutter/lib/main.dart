import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/services/ble_service.dart';
import 'package:greenguard/services/bthome/bthome.dart';
import 'package:greenguard/services/database_helper.dart';
import 'package:greenguard/services/plant_service.dart';
import 'package:greenguard/ui/theme/dynamic_theme_builder.dart';
import 'package:greenguard/ui/views/navigation/navigation_view.dart';
import 'package:workmanager/workmanager.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  await locator<DatabaseHelper>().initialize();
  await locator<BleService>().initialize();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  runApp(const GreenGuardApp());
}

class GreenGuardApp extends StatefulWidget {
  const GreenGuardApp({super.key});

  @override
  GreenGuardAppState createState() => GreenGuardAppState();
}

class GreenGuardAppState extends State<GreenGuardApp> with WidgetsBindingObserver {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onDetach: _onDetach,
      onPause: _onPause,
    );
  }

  Future<void> _onPause() async {
    await Workmanager().registerPeriodicTask(
      "periodic_scan",
      "periodic_scan"
    );
  }

  Future<void> _onDetach() async {
    await Workmanager().registerPeriodicTask(
      "periodic_scan",
      "periodic_scan"
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const DynamicThemeBuilder(
      title: 'GreenGuard',
      home: NavigationView(),
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await setupLocator();
      await locator<DatabaseHelper>().initialize();
      await locator<BleService>().initialize();

      var bleService = locator<BleService>();
      var plantService = locator<PlantService>();

      var scanResults = <ScanResult>[];

      var scanSubscription = bleService.scanResults.listen((List<ScanResult> results) {
        scanResults = results;
      });

      await bleService.startScanning(timeout: 20);
      await Future.delayed(const Duration(seconds: 20));

      scanSubscription.cancel();

      if (scanResults.isEmpty) {
        return Future.value(true);
      }

      var plantsWithSensors = await plantService.getPlantsWithBthomeSensor();

      if (plantsWithSensors.isEmpty) {
        return Future.value(true);
      }

      for (var plant in plantsWithSensors) {
        var sensorData = scanResults.firstWhere((element) => element.device.remoteId.toString() == plant.remoteId);

        var btHomeSensor = BTHomeSensor();
        var soilMoisture = btHomeSensor.parseBTHomeV2(sensorData.advertisementData.serviceData.entries.first.value).first.data;

        await plantService.updateSensorData(plant, soilMoisture: soilMoisture);
      }

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  });
}
