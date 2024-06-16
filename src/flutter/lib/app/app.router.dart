// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i6;
import 'package:flutter/material.dart';
import 'package:greenguard/models/plant.dart' as _i7;
import 'package:greenguard/ui/views/home/home_view.dart' as _i2;
import 'package:greenguard/ui/views/plants/plant_detail_view.dart' as _i5;
import 'package:greenguard/ui/views/plants/plants_view.dart' as _i3;
import 'package:greenguard/ui/views/settings/settings_view.dart' as _i4;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i8;

class Routes {
  static const homeView = '/';

  static const plantsView = '/plants-view';

  static const settingsView = '/settings-view';

  static const plantDetailView = '/plant-detail-view';

  static const all = <String>{
    homeView,
    plantsView,
    settingsView,
    plantDetailView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.plantsView,
      page: _i3.PlantsView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i4.SettingsView,
    ),
    _i1.RouteDef(
      Routes.plantDetailView,
      page: _i5.PlantDetailView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.PlantsView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.PlantsView(),
        settings: data,
      );
    },
    _i4.SettingsView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.SettingsView(),
        settings: data,
      );
    },
    _i5.PlantDetailView: (data) {
      final args = data.getArgs<PlantDetailViewArguments>(nullOk: false);
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i5.PlantDetailView(key: args.key, plant: args.plant),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class PlantDetailViewArguments {
  const PlantDetailViewArguments({
    this.key,
    required this.plant,
  });

  final _i6.Key? key;

  final _i7.Plant plant;

  @override
  String toString() {
    return '{"key": "$key", "plant": "$plant"}';
  }

  @override
  bool operator ==(covariant PlantDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.plant == plant;
  }

  @override
  int get hashCode {
    return key.hashCode ^ plant.hashCode;
  }
}

extension NavigatorStateExtension on _i8.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPlantsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.plantsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPlantDetailView({
    _i6.Key? key,
    required _i7.Plant plant,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.plantDetailView,
        arguments: PlantDetailViewArguments(key: key, plant: plant),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPlantsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.plantsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPlantDetailView({
    _i6.Key? key,
    required _i7.Plant plant,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.plantDetailView,
        arguments: PlantDetailViewArguments(key: key, plant: plant),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
