import 'package:flutter/material.dart';
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
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400.0,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return const Card(
                        //color: Colors.teal[100 * (index % 9)],
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Symbols.spa),
                              title: Text('Pflanze'),
                              subtitle: Text('Kurze Beschreibung'),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 8,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: NewPlantActionButton(
            onAddPlantPressed: () => viewModel.showNewPlantSheet(context),
          ),
        );
      },
    );
  }
}
