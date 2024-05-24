import 'package:flutter/material.dart';
import 'package:greenguard/ui/views/settings/settings_viewmodel.dart';
import 'package:greenguard/ui/widgets/custom_sliver_app_bar.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, viewModel, child) {
        return const CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              title: Text('Einstellungen'),
              isMainView: true,
            ),
          ],
        );
      },
    );
  }
}
