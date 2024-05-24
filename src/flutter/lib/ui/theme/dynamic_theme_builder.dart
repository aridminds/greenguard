import 'dart:ui';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:greenguard/app/app.router.dart';
import 'package:greenguard/ui/theme/theme.dart';
import 'package:stacked_services/stacked_services.dart';

class DynamicThemeBuilder extends StatefulWidget {
  const DynamicThemeBuilder({
    super.key,
    required this.title,
    required this.home,
  });
  final String title;
  final Widget home;

  @override
  State<DynamicThemeBuilder> createState() => _DynamicThemeBuilderState();
}

class _DynamicThemeBuilderState extends State<DynamicThemeBuilder>
    with WidgetsBindingObserver {
  Brightness brightness = PlatformDispatcher.instance.platformBrightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        final ThemeData lightDynamicTheme = ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme?.harmonized(),
          textTheme: ThemeData.light().textTheme,
        );
        final ThemeData darkDynamicTheme = ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorScheme: darkColorScheme?.harmonized(),
          textTheme: ThemeData.dark().textTheme,
        );
        return DynamicTheme(
          themeCollection: ThemeCollection(
            themes: {
              0: brightness == Brightness.light
                  ? lightCustomTheme
                  : darkCustomTheme,
              1: brightness == Brightness.light
                  ? lightDynamicTheme
                  : darkDynamicTheme,
              // 2: lightCustomTheme,
              // 3: lightDynamicTheme,
              // 4: darkCustomTheme,
              // 5: darkDynamicTheme,
            },
            fallbackTheme: PlatformDispatcher.instance.platformBrightness ==
                Brightness.light
                ? lightCustomTheme
                : darkCustomTheme,
          ),
          builder: (context, theme) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: widget.title,
            navigatorKey: StackedService.navigatorKey,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            theme: theme,
            home: widget.home,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}