import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/models/chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/constants/date_format.dart';

class CircularChartWidget extends ConsumerWidget {
  final String dateType;
  final List<ChartModel> data;
  final double spends;
  const CircularChartWidget(
      {super.key, required this.dateType, required this.data, this.spends = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = data.fold<double>(0, (sum, item) => sum + item.y);

    return Container(
      color: Colors.grey[200],
      child: data.isEmpty
          ? Center(
              child: Text(S.current.spendingNotExists(S.current.dateItems
                  .split('|')[dateFormat.indexOf(dateType)]
                  .toLowerCase())),
            )
          : Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data
                          .fold<double>(0, (sum, item) => sum + item.y)
                          .toStringAsFixed(1),
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SfCircularChart(
                  series: <DoughnutSeries<ChartModel, String>>[
                    DoughnutSeries<ChartModel, String>(
                      dataSource: data,
                      innerRadius: '35%',
                      pointColorMapper: (ChartModel data, _) =>
                          Color(int.parse('0x${data.color}')),
                      xValueMapper: (ChartModel data, _) => data.x,
                      yValueMapper: (ChartModel data, _) => data.y,
                      dataLabelMapper: (ChartModel data, _) =>
                          data.x.isEmpty ? '_' : data.x,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          height: 1.2,
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                if (spends > 0)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      S.current.balanceSum((total - spends).toStringAsFixed(1)),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
    );
  }
}
