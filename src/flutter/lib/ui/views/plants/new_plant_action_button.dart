import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_symbols_icons/symbols.dart';

class NewPlantActionButton extends StatelessWidget {
  const NewPlantActionButton({super.key, this.onAddPlantPressed, this.onAddPlantBluetoothPressed});

  final Function? onAddPlantPressed;
  final Function? onAddPlantBluetoothPressed;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      icon: Symbols.psychiatry,
      spacing: 16,
      childMargin: EdgeInsets.zero,
      childPadding: const EdgeInsets.all(8.0),
      children: [
        SpeedDialChild(
          child: const Icon(Symbols.add),
          label: 'Manuell',
          labelBackgroundColor: Theme.of(context).colorScheme.primary,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          onTap: () {
            onAddPlantPressed!();
          },
        ),
        SpeedDialChild(
          child: const Icon(Symbols.bluetooth),
          label: 'Bluetooth (BTHome)',
          labelBackgroundColor: Theme.of(context).colorScheme.primary,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          onTap: () {
            onAddPlantBluetoothPressed!();
          },
        ),
      ],
    );
  }
}
