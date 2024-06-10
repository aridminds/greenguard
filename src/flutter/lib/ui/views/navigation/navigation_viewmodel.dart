import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/app/app.router.dart';
import 'package:greenguard/services/foreground_service/foreground_task_service.dart';
import 'package:greenguard/ui/views/home/home_view.dart';
import 'package:greenguard/ui/views/plants/plants_view.dart';
import 'package:greenguard/ui/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NavigationViewModel extends IndexTrackingViewModel {
  final _navigationService = locator<NavigationService>();
  final _foregroundTaskService = locator<ForegroundTaskService>();

  Future<void> initialize(BuildContext context) async {
    //final dynamicTheme = DynamicTheme.of(context)!;
    //await dynamicTheme.setTheme(0);

    await _foregroundTaskService.requestPermissionForAndroid();

    if (await FlutterForegroundTask.isRunningService) {
      final newReceivePort = FlutterForegroundTask.receivePort;
      _foregroundTaskService.registerReceivePort(newReceivePort);
    }

    await _foregroundTaskService.startForegroundTask();
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

  @override
  void dispose() {
    _foregroundTaskService.closeReceivePort();
    super.dispose();
  }
}
