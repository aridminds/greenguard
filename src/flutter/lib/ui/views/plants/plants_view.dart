import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/models/plant.dart';
import 'package:greenguard/ui/views/plants/new_plant_action_button.dart';
import 'package:greenguard/ui/views/plants/plants_viewmodel.dart';
import 'package:greenguard/ui/widgets/custom_sliver_app_bar.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:stacked/stacked.dart';

class PlantsView extends StatelessWidget {
  const PlantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlantsViewModel>.reactive(
      viewModelBuilder: () => locator<PlantsViewModel>(),
      onViewModelReady: (model) => model.initialize(context),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, viewModel, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              const CustomSliverAppBar(
                title: Text('Meine Pflanzen'),
                isMainView: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(20.0),
                sliver: viewModel.plants.isEmpty
                    ? const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Symbols.psychiatry, size: 48),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(left: 32, right: 32),
                                child: Text("Füge Pflanzen über den Button am unteren Bildschirmrand hinzu.", //put your own long text here.
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center),
                              )
                            ],
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final plant = viewModel.plants[index];
                            return Card(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12.0),
                                child: ListTile(
                                  leading: Icon(plant.isBluetooth ? Symbols.bluetooth : Symbols.potted_plant),
                                  title: Text(plant.name),
                                  subtitle: Text(plant.description),
                                ),
                                onTap: () => viewModel.tapPlant(plant),
                                onLongPress: () => viewModel.longPressPlant(plant),
                              ),
                            );
                          },
                          childCount: viewModel.plants.length,
                        ),
                      ),
              ),
            ],
          ),
          floatingActionButton: NewPlantActionButton(
            onAddPlantPressed: () => viewModel.showNewPlantSheet(context),
            onAddPlantBluetoothPressed: () => viewModel.showNewPlantSheet(context, isBluetooth: true),
          ),
        );
      },
    );
  }
}
