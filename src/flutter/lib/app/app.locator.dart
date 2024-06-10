// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/ble_service.dart';
import '../services/database_helper.dart';
import '../services/foreground_service/collect_bthome_data_task.dart';
import '../services/foreground_service/foreground_task_service.dart';
import '../services/plant_service.dart';
import '../ui/views/home/home_viewmodel.dart';
import '../ui/views/navigation/navigation_viewmodel.dart';
import '../ui/views/plants/plants_viewmodel.dart';
import '../ui/views/settings/settings_viewmodel.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationViewModel());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => PlantsViewModel());
  locator.registerLazySingleton(() => SettingsViewModel());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DatabaseHelper());
  locator.registerLazySingleton(() => PlantService());
  locator.registerLazySingleton(() => ForegroundTaskService());
  locator.registerLazySingleton(() => BleService());
  locator.registerLazySingleton(() => CollectBthomeDataTask());
}
