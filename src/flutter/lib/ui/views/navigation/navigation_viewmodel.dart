import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/app/app.router.dart';
import 'package:greenguard/main.dart';
import 'package:greenguard/ui/views/home/home_view.dart';
import 'package:greenguard/ui/views/plants/plants_view.dart';
import 'package:greenguard/ui/views/settings/settings_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workmanager/workmanager.dart';

class NavigationViewModel extends IndexTrackingViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> initialize(BuildContext context) async {
    //final dynamicTheme = DynamicTheme.of(context)!;
    //await dynamicTheme.setTheme(0);

    const ignoreBatteryOptimizations = Permission.ignoreBatteryOptimizations;
    const notification = Permission.notification;
    const bluetoothScan = Permission.bluetoothScan;

    if (await ignoreBatteryOptimizations.isDenied) {
      await ignoreBatteryOptimizations.request();
    }

    if (await notification.isDenied) {
      await notification.request();
    }

    if (await bluetoothScan.isDenied) {
      await bluetoothScan.request();
    }

    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }

  void navigateToHomeView() {
    _navigationService.navigateTo(Routes.homeView);
  }

  void navigateToPlantsView() {
    _navigationService.navigateTo(Routes.plantsView);
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const PlantsView();
      case 2:
        return const SettingsView();
      default:
        return const HomeView();
    }
  }
}
