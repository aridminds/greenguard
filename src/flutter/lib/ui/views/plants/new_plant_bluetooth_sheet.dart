import 'package:flutter/material.dart';
import 'package:greenguard/ui/views/plants/new_plant_bluetooth_sheet_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NewPlantBluetoothSheet extends StatelessWidget {
  const NewPlantBluetoothSheet({super.key, this.onPlantAdded});

  final Function? onPlantAdded;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewPlantBluetoothSheetViewmodel>.reactive(
      onViewModelReady: (model) => model.initialize(context),
      viewModelBuilder: () => NewPlantBluetoothSheetViewmodel(onPlantAdded: onPlantAdded),
      builder: (context, viewModel, child) {
        return DraggableScrollableSheet(
          expand: false,
          snap: true,
          initialChildSize: 0.90,
          minChildSize: 0.5,
          maxChildSize: 0.90,
          shouldCloseOnMinExtent: false,
          builder: (_, scrollContainer) => ListView(
            controller: scrollContainer,
            children: <Widget>[
              ...viewModel.buildPlantDeviceList()],
          ),
        );
      },
    );
  }
}
