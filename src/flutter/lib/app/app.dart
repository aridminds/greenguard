import 'package:greenguard/services/ble_service.dart';
import 'package:greenguard/services/database_helper.dart';
import 'package:greenguard/services/plant_service.dart';
import 'package:greenguard/ui/views/home/home_view.dart';
import 'package:greenguard/ui/views/home/home_viewmodel.dart';
import 'package:greenguard/ui/views/navigation/navigation_viewmodel.dart';
import 'package:greenguard/ui/views/plants/plant_detail_view.dart';
import 'package:greenguard/ui/views/plants/plant_detail_view_viewmodel.dart';
import 'package:greenguard/ui/views/plants/plants_view.dart';
import 'package:greenguard/ui/views/plants/plants_viewmodel.dart';
import 'package:greenguard/ui/views/settings/settings_view.dart';
import 'package:greenguard/ui/views/settings/settings_viewmodel.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: PlantsView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: PlantDetailView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationViewModel),
    LazySingleton(classType: HomeViewModel),
    LazySingleton(classType: PlantsViewModel),
    LazySingleton(classType: PlantDetailViewmodel),
    LazySingleton(classType: SettingsViewModel),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DatabaseHelper),
    LazySingleton(classType: PlantService),
    LazySingleton(classType: BleService)
  ],
)
class AppSetup {}
