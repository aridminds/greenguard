import 'package:flutter/material.dart';
import 'package:greenguard/ui/views/plants/new_plant_sheet_viewmodel.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:stacked/stacked.dart';

class NewPlantSheet extends StatelessWidget {
  const NewPlantSheet({super.key, this.onPlantAdded});

  final Function? onPlantAdded;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewPlantSheetViewmodel>.reactive(
      onViewModelReady: (model) => model.initialize(context),
      viewModelBuilder: () =>
          NewPlantSheetViewmodel(onPlantAdded: onPlantAdded),
      builder: (context, viewModel, child) {
        return DraggableScrollableSheet(
          expand: false,
          snap: true,
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (_, scrollContainer) => SingleChildScrollView(
            controller: scrollContainer,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 24.0, left: 24.0, right: 24.0, bottom: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 16),
                    TextField(
                      controller: viewModel.plantNameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Symbols.psychiatry),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: viewModel.plantDescriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Beschreibung',
                        prefixIcon: Icon(Symbols.menu_book),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: viewModel.newPlantButtonEnabled
                          ? () async => await viewModel.addPlant(context)
                          : null,
                      child: const Text('Hinzufügen'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
