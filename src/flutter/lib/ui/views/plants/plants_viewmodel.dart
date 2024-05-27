import 'package:flutter/material.dart';
import 'package:greenguard/ui/views/plants/new_plant_sheet.dart';
import 'package:stacked/stacked.dart';

class PlantsViewModel extends BaseViewModel {
  Future<void> showNewPlantSheet(BuildContext parentContext) {
    return showModalBottomSheet(
      context: parentContext,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) => NewPlantSheet(onPlantAdded: notifyListeners),
    );
  }
}
