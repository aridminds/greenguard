import 'package:greenguard/services/ble_service.dart';
import 'package:greenguard/services/database_helper.dart';
import 'package:greenguard/services/foreground_service/collect_bthome_data_task.dart';
import 'package:greenguard/services/foreground_service/foreground_task_service.dart';
import 'package:greenguard/services/plant_service.dart';
import 'package:greenguard/ui/views/home/home_viewmodel.dart';
import 'package:greenguard/ui/views/plants/plants_view.dart';
import 'package:greenguard/ui/views/plants/plants_viewmodel.dart';
import 'package:greenguard/ui/views/settings/settings_viewmodel.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/views/home/home_view.dart';
import '../ui/views/navigation/navigation_viewmodel.dart';

@StackedApp(
  routes: [MaterialRoute(page: HomeView, initial: true), MaterialRoute(page: PlantsView)],
  dependencies: [
    LazySingleton(classType: NavigationViewModel),
    LazySingleton(classType: HomeViewModel),
    LazySingleton(classType: PlantsViewModel),
    LazySingleton(classType: SettingsViewModel),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DatabaseHelper),
    LazySingleton(classType: PlantService),
    LazySingleton(classType: ForegroundTaskService),
    LazySingleton(classType: BleService),
    LazySingleton(classType: CollectBthomeDataTask),
  ],
)
class AppSetup {}
