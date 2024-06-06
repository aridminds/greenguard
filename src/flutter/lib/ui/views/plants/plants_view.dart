import 'package:flutter/material.dart';
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
      viewModelBuilder: () => PlantsViewModel(),
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
                sliver: FutureBuilder<List<Plant>>(
                  future: viewModel.getPlants(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final plants = snapshot.data!;
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final plant = plants[index];
                            return Card(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12.0),
                                child: ListTile(
                                  leading: Icon(plant.bthome ? Symbols.bluetooth : Symbols.potted_plant),
                                  title: Text(plant.name),
                                  subtitle: Text(plant.description),
                                ),
                                onTap: () => viewModel.tapPlant(plant),
                                onLongPress: () =>
                                    viewModel.longPressPlant(plant),
                              ),
                            );
                          },
                          childCount: plants.length,
                        ),
                      );
                    } else {
                      return const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
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
