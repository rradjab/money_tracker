import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/dialogs/to_spends_dialog.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/models/chart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:money_tracker/constants/date_format.dart';
import 'package:money_tracker/dialogs/confirm_dialog.dart';
import 'package:money_tracker/dialogs/item_add_dialog.dart';
import 'package:money_tracker/providers/plans/providers.dart';
import 'package:money_tracker/widgets/circular_chart_widget.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class PlanWidget extends ConsumerWidget {
  const PlanWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expDate = ref.watch(plansExpDateProvider);
    final dateType = ref.watch(plansDatePickerProvider);

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
                        child: Text(S.current.dateItems.split('|')[i]))
                ],
                onChanged: (v) {
                  ref
                      .read(plansDatePickerProvider.notifier)
                      .update((state) => v!);
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
                      initialDate: expDate.copyWith(),
                      firstDate: DateTime.now(),
                      dateFormat: dateType,
                      locale: DateTimePickerLocale.en_us,
                      looping: true,
                    );

                    if (selectedDate != null &&
                        (selectedDate.isAfter(DateTime.now()) ||
                            expDate.day == selectedDate.day)) {
                      ref.read(plansExpDateProvider.notifier).update((state) =>
                          dateType != dateFormat[0]
                              ? selectedDate.copyWith(day: DateTime.now().day)
                              : selectedDate);
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
                onPressed: () {
                  final dialogDate = ref.watch(plansExpDateProvider);
                  final nDate = DateTime.now();
                  final dDate = DateTime(
                      dialogDate.year, dialogDate.month, dialogDate.day);
                  final tDate = DateTime(nDate.year, nDate.month, nDate.day);

                  ref.read(dialogDateProvider.notifier).update((state) =>
                      dDate == tDate
                          ? dialogDate.copyWith(day: dialogDate.day + 1)
                          : dialogDate);
                  showItemAddDialog(context, '');
                },
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
                              e.name ?? '',
                              e.cost ?? 0,
                              e.color ??
                                  Color(Random().nextInt(0xffffffff))
                                      .withAlpha(0xff)
                                      .toString()
                                      .substring(8, 16)))
                          .toList(),
                      dateType: dateType,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => Card(
                          //color: Color(int.parse('0x${data[index].color}')),
                          margin: const EdgeInsets.all(20),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ListTile(
                            onTap: () {
                              ref.read(dialogDateProvider.notifier).update(
                                  (state) => ref.watch(plansExpDateProvider));
                              showToSpendsAddDialog(context, data[index]);
                            },
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
                                data[index].name ?? '',
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
                                    : DateFormat(S.current.dateFormat)
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
