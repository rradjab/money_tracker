import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/views/spending_view.dart';
import 'package:money_tracker/dialogs/confirm_dialog.dart';
import 'package:money_tracker/dialogs/add_spend_dialog.dart';
import 'package:money_tracker/dialogs/add_category_dialog.dart';
import 'package:money_tracker/services/categories_service.dart';
import 'package:money_tracker/widgets/circular_chart_widget.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expDate = ref.watch(exploreDateProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: InkWell(
              onTap: () async {
                DateTime? selectedDate = await showMonthPicker(
                  context: context,
                  initialDate: expDate,
                  firstDate: DateTime(1900, 12, 10),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null &&
                    !expDate.isAtSameMomentAs(selectedDate) &&
                    !selectedDate.isAfter(DateTime.now()) &&
                    !selectedDate.isBefore(DateTime(1900))) {
                  ref.read(exploreDateProvider.notifier).update((state) =>
                      selectedDate.copyWith(day: DateTime.now().day));
                  ref.read(spendDateProvider.notifier).update((state) =>
                      selectedDate.copyWith(day: DateTime.now().day));
                }
              },
              child: Text(DateFormat.yMMMM().format(expDate))),
        ),
        actions: [
          IconButton(
              onPressed: () => showCategoryAddDialog(context),
              icon: const Icon(Icons.add))
        ],
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
