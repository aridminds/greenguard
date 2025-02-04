import 'package:flutter/material.dart';
import 'package:greenguard/models/plant.dart';
import 'package:greenguard/models/watering_need.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_symbols_icons/symbols.dart';

class PlantTileWithWateringInfo extends StatelessWidget {
  const PlantTileWithWateringInfo({super.key, required this.plant, this.onWateringPressed});

  final Plant plant;
  final Function? onWateringPressed;

  Widget _getWateringIcon() {
    switch (plant.wateringNeed) {
      case WateringNeed.low:
        return const Icon(Symbols.humidity_low);
      case WateringNeed.medium:
        return const Icon(Symbols.humidity_mid);
      case WateringNeed.high:
        return const Icon(Symbols.humidity_high);
    }
  }

  Widget _getWateringButton(BuildContext context) {
    return plant.isBluetooth
        ? const Padding(padding: EdgeInsets.all(12), child: Icon(Symbols.sensors))
        : IconButton(
            icon: const Icon(Symbols.water_drop),
            onPressed: () => onWateringPressed?.call(),
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
              backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
            ),
          );
  }

  Widget _getText(BuildContext context) {
    String createdAtLabel = "";
    String soilMoistureLabel = "";

    if (plant.latestSensorData != null) {
      initializeDateFormatting('de');
      createdAtLabel = DateFormat.yMd('de').add_Hms().format(plant.latestSensorData!.createdAt);
      soilMoistureLabel = "${plant.latestSensorData!.soilMoisture}%";
    } else {
      createdAtLabel = "Keine Daten";
      soilMoistureLabel = "Keine Daten";
    }

    return plant.isBluetooth
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(plant.name, style: Theme.of(context).textTheme.bodyLarge),
              Text("Bodenfeuchtigkeit: $soilMoistureLabel", style: Theme.of(context).textTheme.bodySmall),
              Text("Erfasst: $createdAtLabel", style: Theme.of(context).textTheme.bodySmall),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Text(plant.name, style: Theme.of(context).textTheme.bodyLarge)],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 14, right: 16, bottom: 14),
        child: Row(
          children: <Widget>[_getWateringIcon(), const SizedBox(width: 16), _getText(context), const Spacer(), _getWateringButton(context)],
        ),
      ),
    );
  }
}
