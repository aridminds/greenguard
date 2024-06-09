import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:stacked/stacked.dart';
import 'navigation_viewmodel.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationViewModel>.reactive(
      onViewModelReady: (model) => model.initialize(context),
      viewModelBuilder: () => locator<NavigationViewModel>(),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) {
        return Scaffold(
          body: model.getViewForIndex(model.currentIndex),
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: model.setIndex,
            selectedIndex: model.currentIndex,
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Symbols.home_and_garden),
                label: 'Übersicht',
              ),
              NavigationDestination(
                icon: Icon(Symbols.potted_plant),
                label: 'Pflanzen',
              ),
              NavigationDestination(
                icon: Icon(Symbols.settings),
                label: 'Einstellungen',
              ),
            ],
          ),
        );
      },
    );
  }
}
