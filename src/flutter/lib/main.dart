import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/db/database_helper.dart';
import 'package:greenguard/ui/theme/dynamic_theme_builder.dart';
import 'package:greenguard/ui/views/navigation/navigation_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  locator<DatabaseHelper>().initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DynamicThemeBuilder(
      title: 'GreenGuard',
      home: NavigationView(),
    );
  }
}
