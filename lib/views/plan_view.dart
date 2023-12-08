import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/models/chart_model.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/services/plans_service.dart';
import 'package:money_tracker/dialogs/confirm_dialog.dart';
import 'package:money_tracker/dialogs/add_plan_dialog.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:money_tracker/widgets/circular_chart_widget.dart';

class PlanWidget extends ConsumerWidget {
  const PlanWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expDate = ref.watch(exploreDateProvider);
    final dateType = ref.watch(datePickerProvider);
    final List<String> dateFormat = ['dd M yyyy', 'M yyyy', 'yyyy', ''];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButton(
                value: dateType,
                isDense: true,
                items: [
                  for (int i = 0; i < dateFormat.length; i++)
                    DropdownMenuItem(
                        value: dateFormat[i],
                        child: Text(S.of(context).dateItems.split('|')[i]))
                ],
                onChanged: (v) {
                  ref.read(datePickerProvider.notifier).update((state) => v!);
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () async {
                  if (dateType.isNotEmpty) {
                    DateTime? selectedDate =
                        await DatePicker.showSimpleDatePicker(
                      context,
                      // initialDate: DateTime(2020),
                      initialDate: expDate,
                      firstDate: DateTime(1900, 12, 10),
                      lastDate: DateTime.now(),
                      dateFormat: dateType,
                      locale: DateTimePickerLocale.en_us,
                      looping: true,
                    );
                    if (selectedDate != null &&
                        !expDate.isAtSameMomentAs(selectedDate) &&
                        !selectedDate.isAfter(DateTime.now()) &&
                        !selectedDate.isBefore(DateTime(1900))) {
                      if (dateType != 'dd M yyyy') {
                        ref.read(exploreDateProvider.notifier).update((state) =>
                            selectedDate.copyWith(day: DateTime.now().day));
                        ref.read(spendDateProvider.notifier).update((state) =>
                            selectedDate.copyWith(day: DateTime.now().day));
                      } else {
                        ref
                            .read(exploreDateProvider.notifier)
                            .update((state) => selectedDate);
                        ref
                            .read(spendDateProvider.notifier)
                            .update((state) => selectedDate);
                      }
                    }
                  }
                },
                child: Text(
                  DateFormat(dateType).format(expDate),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () => showPlanAddDialog(context),
                icon: const Icon(Icons.add),
                alignment: Alignment.centerRight,
              ),
            ),
          ],
        ),
      ),
      body: ref.watch(firebasePlans).when(
            data: ((data) {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: CircularChartWidget(
                      data: data
                          .where((e) => (e.cost != null && e.cost! > 0))
                          .map((e) => ChartModel(
                              e.name ?? 'unnamed',
                              e.cost ?? 0,
                              Color(Random().nextInt(0xffffffff))
                                  .withAlpha(0xff)
                                  .toString()
                                  .substring(8, 16)))
                          .toList(),
                      date: expDate,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.all(20),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ListTile(
                            onLongPress: () async {
                              if (await confirmDismiss(context)) {
                                ref
                                    .read(firebasePlansControl.notifier)
                                    .deletePlan(data[index].id!);
                              }
                            },
                            title: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                data[index].name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                data[index].added == null
                                    ? '00 00 0000 / 00:00'
                                    : DateFormat(S.of(context).spendsDateFormat)
                                        .format(data[index].added!.toDate()),
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                data[index].cost?.toStringAsFixed(1) ?? '0',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            error: (Object error, StackTrace stackTrace) => Text(
              error.toString(),
              style: const TextStyle(color: Colors.amber, fontSize: 45),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
