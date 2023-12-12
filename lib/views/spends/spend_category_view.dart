import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/models/chart_model.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/constants/date_format.dart';
import 'package:money_tracker/dialogs/confirm_dialog.dart';
import 'package:money_tracker/dialogs/item_add_dialog.dart';
import 'package:money_tracker/providers/spends/providers.dart';
import 'package:money_tracker/views/spends/spending_view.dart';
import 'package:money_tracker/dialogs/category_add_dialog.dart';
import 'package:money_tracker/widgets/circular_chart_widget.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expDate = ref.watch(spendsDateProvider);
    final dateType = ref.watch(spendsDatePickerProvider);

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
                      .read(spendsDatePickerProvider.notifier)
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
                      if (dateType != dateFormat[0]) {
                        ref.read(spendsDateProvider.notifier).update((state) =>
                            selectedDate.copyWith(day: DateTime.now().day));
                        ref.read(dialogDateProvider.notifier).update((state) =>
                            selectedDate.copyWith(day: DateTime.now().day));
                      } else {
                        ref
                            .read(spendsDateProvider.notifier)
                            .update((state) => selectedDate);
                        ref
                            .read(dialogDateProvider.notifier)
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
      body: ref.watch(spendsCategoriesStreamProvider).when(
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
                      dateType: dateType,
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
                            onTap: () {
                              ref.read(dialogDateProvider.notifier).update(
                                  (state) => ref.watch(spendsDateProvider));
                              showItemAddDialog(context, dataSorted[index].id!);
                            },
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
                                    ? S.current.dialogAddSpend
                                    : S.current.totalSpendsN(dataSorted[index]
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
                                    categoryModel: dataSorted[index],
                                    streamProvider: spendsStreamProvider,
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
