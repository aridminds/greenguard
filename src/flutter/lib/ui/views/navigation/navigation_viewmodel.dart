import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/app/app.router.dart';
import 'package:greenguard/ui/views/home/home_view.dart';
import 'package:greenguard/ui/views/plants/plants_view.dart';
import 'package:greenguard/ui/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NavigationViewModel extends IndexTrackingViewModel {
  Future<void> initialize(BuildContext context) async {
    final dynamicTheme = DynamicTheme.of(context)!;
    //await dynamicTheme.setTheme(0);
  }

  final _navigationService = locator<NavigationService>();

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
