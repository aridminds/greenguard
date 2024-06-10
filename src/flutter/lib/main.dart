import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/services/ble_service.dart';
import 'package:greenguard/services/database_helper.dart';
import 'package:greenguard/services/foreground_service/foreground_task_service.dart';
import 'package:greenguard/services/foreground_service/scan_task_handler.dart';
import 'package:greenguard/ui/theme/dynamic_theme_builder.dart';
import 'package:greenguard/ui/views/navigation/navigation_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  await locator<DatabaseHelper>().initialize();
  await locator<BleService>().initialize();
  locator<ForegroundTaskService>().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const WithForegroundTask(
      child: DynamicThemeBuilder(
        title: 'GreenGuard',
        home: NavigationView(),
      ),
    );
  }
}

// The callback function should always be a top-level function.
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(ScanTaskHandler());
}
