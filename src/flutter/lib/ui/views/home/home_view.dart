import 'package:flutter/material.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/models/watering_need.dart';
import 'package:greenguard/ui/views/home/home_viewmodel.dart';
import 'package:greenguard/ui/widgets/custom_sliver_app_bar.dart';
import 'package:greenguard/ui/widgets/plants/plant_tile_with_watering.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => locator<HomeViewModel>(),
      onViewModelReady: (model) => model.initialize(context),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, viewModel, child) {
        return CustomScrollView(
          slivers: [
            const CustomSliverAppBar(
              title: Text('Übersicht'),
              isMainView: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  <Widget>[
                    Text("Heute", style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: viewModel.plantsWithWateringNeedsLow.isEmpty
                          ? const Card(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Symbols.water_drop, size: 48),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: EdgeInsets.only(left: 32, right: 32),
                                      child: Text("Deine Pflanzen sind für heute gut versorgt.", //put your own long text here.
                                          maxLines: 3,
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : RefreshIndicator(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: viewModel.plantsWithWateringNeedsLow.length,
                                itemBuilder: (context, index) {
                                  final plant = viewModel.plantsWithWateringNeedsLow[index];
                                  return PlantTileWithWateringInfo(
                                      plant: plant,
                                      onWateringPressed: () {
                                        viewModel.waterPlant(plant);
                                      });
                                },
                              ),
                              onRefresh: () => viewModel.refreshPlants(wateringNeed: WateringNeed.low),
                            ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Demnächst",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: viewModel.plantsWithWateringNeedsMedium.isEmpty
                          ? const Card(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Symbols.water_drop, size: 48),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: EdgeInsets.only(left: 32, right: 32),
                                      child: Text("Deine Pflanzen sind für die nächsten Tage gut versorgt.", //put your own long text here.
                                          maxLines: 3,
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : RefreshIndicator(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: viewModel.plantsWithWateringNeedsMedium.length,
                                itemBuilder: (context, index) {
                                  final plant = viewModel.plantsWithWateringNeedsMedium[index];
                                  return PlantTileWithWateringInfo(
                                    plant: plant,
                                    onWateringPressed: () {
                                      viewModel.waterPlant(plant);
                                    },
                                  );
                                },
                              ),
                              onRefresh: () => viewModel.refreshPlants(wateringNeed: WateringNeed.medium),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
