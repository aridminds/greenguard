import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:greenguard/app/app.locator.dart';
import 'package:greenguard/models/plant.dart';
import 'package:greenguard/models/sensor_data.dart';
import 'package:greenguard/ui/views/plants/plant_detail_view_viewmodel.dart';
import 'package:greenguard/ui/widgets/custom_sliver_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:stacked/stacked.dart';

class PlantDetailView extends StatelessWidget {
  const PlantDetailView({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlantDetailViewmodel>.reactive(
      viewModelBuilder: () => locator<PlantDetailViewmodel>(),
      onViewModelReady: (model) => model.initialize(context, plant),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, viewModel, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              CustomSliverAppBar(
                title: Text(plant.name),
                expandedTitleScale: 1.1,
                isMainView: false,
                actions: [
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            leading: Icon(Symbols.edit),
                            title: Text('Bearbeiten'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            leading: Icon(Symbols.delete),
                            title: Text('Löschen'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'clear_data',
                          child: ListTile(
                            leading: Icon(Symbols.delete_history),
                            title: Text('Historie leeren'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                sliver: SliverToBoxAdapter(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bodenfeuchtigkeit', style: Theme.of(context).textTheme.titleSmall),
                          const SizedBox(height: 14),
                          SizedBox(
                            height: 200,
                            child: viewModel.series.isNotEmpty
                                ? Chart(
                                    data: viewModel.series,
                                    variables: {
                                      'createdAt': Variable(
                                        accessor: ((DateTime time, int data) sensorData) => sensorData.$1,
                                        scale: TimeScale(
                                          formatter: (time) => DateFormat('dd.MM').format(time),
                                        ),
                                      ),
                                      'soilMoisture': Variable(
                                        accessor: ((DateTime time, int data) sensorData) => sensorData.$2,
                                        scale: LinearScale(
                                          niceRange: true,
                                          min: 0,
                                          max: 100,
                                          formatter: (value) => '${NumberFormat("###").format(value)} %',
                                          ticks: [25, 50, 75, 100],
                                        ),
                                      ),
                                    },
                                    marks: [
                                      LineMark(
                                        shape: ShapeEncode(value: BasicLineShape(smooth: false)),
                                        color: ColorEncode(value: Theme.of(context).colorScheme.primary),
                                      )
                                    ],
                                    axes: [
                                      AxisGuide(
                                        line: PaintStyle(
                                          strokeColor: Theme.of(context).colorScheme.onSurface,
                                          strokeWidth: 0.5,
                                        ),
                                        label: LabelStyle(
                                          textStyle: TextStyle(
                                            fontSize: 10,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                          offset: const Offset(0, 7.5),
                                        ),
                                      ),
                                      AxisGuide(
                                        label: LabelStyle(
                                          textStyle: TextStyle(
                                            fontSize: 10,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                          offset: const Offset(-7.5, 0),
                                        ),
                                        grid: PaintStyle(
                                          strokeColor: Theme.of(context).colorScheme.onSurface,
                                          strokeWidth: 0.5,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Center(
                                    child: Text('Keine Daten vorhanden'),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
