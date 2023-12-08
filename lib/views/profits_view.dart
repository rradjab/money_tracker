import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/models/chart_model.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/views/spending_view.dart';
import 'package:money_tracker/dialogs/confirm_dialog.dart';
import 'package:money_tracker/dialogs/add_spend_dialog.dart';
import 'package:money_tracker/dialogs/add_category_dialog.dart';
import 'package:money_tracker/services/categories_service.dart';
import 'package:money_tracker/widgets/circular_chart_widget.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class ProfitWidget extends ConsumerWidget {
  const ProfitWidget({super.key});

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
                onPressed: () => showCategoryAddDialog(context),
                icon: const Icon(Icons.add),
                alignment: Alignment.centerRight,
              ),
            ),
          ],
        ),
      ),
      body: ref.watch(firebaseCategories).when(
            data: ((data) {
              final dataSorted = data
                ..sort((a, b) => b.total!.compareTo(a.total!));

              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: CircularChartWidget(
                      data: dataSorted
                          .where((e) => (e.total != null && e.total! > 0))
                          .map((e) => ChartModel(e.name ?? 'unnamed',
                              e.total ?? 0, e.color ?? 'ffffff'))
                          .toList(),
                      date: expDate,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: dataSorted.length,
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
                                    .read(firebaseSpendsControl.notifier)
                                    .deleteCategory(dataSorted[index].id!);
                              }
                            },
                            onTap: () => showSpendAddDialog(
                                context, dataSorted[index].id!),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                dataSorted[index].name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                dataSorted[index].total! <= 0
                                    ? S.of(context).addSpend
                                    : S.of(context).totalSpendsN(
                                        dataSorted[index]
                                                .total
                                                ?.toStringAsFixed(1) ??
                                            '0'),
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SpendingItemView(
                                    spendingModel: dataSorted[index],
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.chevron_right,
                                size: 45.0,
                                color: Color(
                                  int.parse('0x${dataSorted[index].color!}'),
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
