import 'package:flutter/material.dart';
import 'package:greenguard/ui/views/home/home_viewmodel.dart';
import 'package:greenguard/ui/widgets/custom_sliver_app_bar.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return const CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              title: Text('Startseite'),
              isMainView: true,
            ),
          ],
        );
      },
    );
  }
}
