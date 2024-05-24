import 'package:flutter/material.dart';
import 'package:greenguard/ui/views/plants/new_plant_sheet_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NewPlantSheet extends StatelessWidget {
  const NewPlantSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewPlantSheetViewmodel>.reactive(
      viewModelBuilder: () => NewPlantSheetViewmodel(),
      builder: (context, viewModel, child) {
        return DraggableScrollableSheet(
          expand: false,
          snap: true,
          initialChildSize: 0.6,
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
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: viewModel.plantDescriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Beschreibung',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => viewModel.addPlant(context),
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
