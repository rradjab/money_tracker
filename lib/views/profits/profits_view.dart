import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:money_tracker/dialogs/confirm_dialog.dart';
import 'package:money_tracker/dialogs/item_add_dialog.dart';
import 'package:money_tracker/providers/spends/providers.dart';
import 'package:money_tracker/providers/profits/providers.dart';

class ProfitItemView extends ConsumerWidget {
  final CategoryModel categoryModel;
  const ProfitItemView({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel.name!),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                ref
                    .read(dialogDateProvider.notifier)
                    .update((state) => ref.watch(spendsDateProvider));
                showItemAddDialog(context, categoryModel.id!, true);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ref.watch(profitsStreamProvider(categoryModel.id!)).when(
            data: ((data) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
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
                              borderRadius:
                                  BorderRadius.circular(16.0), //<-- SEE HERE
                            ),
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                ref
                                    .read(firebaseProfitsControl.notifier)
                                    .deleteItem(
                                        categoryModel.id!, data[index].id!);
                              },
                              confirmDismiss: (direction) async {
                                return confirmDismiss(context);
                              },
                              background: Container(
                                padding: const EdgeInsets.only(right: 20.0),
                                alignment: Alignment.centerRight,
                                color: Colors.red,
                                child: Text(
                                  S.current.delete,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  data[index].cost.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  data[index].added == null
                                      ? '00 00 0000 / 00:00'
                                      : DateFormat(S.current.spendsDateFormat)
                                          .format(data[index].added!.toDate()),
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
                ),
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
