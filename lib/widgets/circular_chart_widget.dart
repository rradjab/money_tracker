import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircularChartWidget extends StatelessWidget {
  final DateTime date;
  final List<CategoryModel> data;
  const CircularChartWidget(
      {super.key, required this.date, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: data.isEmpty
          ? Center(
              child: Text(S.of(context).spendingNotExists(
                  DateFormat.MMMM().format(date).toString())),
            )
          : Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data
                          .fold<double>(0, (sum, item) => sum + item.total!)
                          .toStringAsFixed(1),
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SfCircularChart(
                  series: <DoughnutSeries<CategoryModel, String>>[
                    DoughnutSeries<CategoryModel, String>(
                      dataSource: data,
                      innerRadius: '35%',
                      pointColorMapper: (CategoryModel data, _) =>
                          Color(int.parse('0x${data.color ?? 'ffffff'}')),
                      xValueMapper: (CategoryModel data, _) => data.name,
                      yValueMapper: (CategoryModel data, _) => data.total,
                      dataLabelMapper: (CategoryModel data, _) => data.name,
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
              ],
            ),
    );
  }
}
