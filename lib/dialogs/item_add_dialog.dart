import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker/providers/plans/providers.dart';
import 'package:money_tracker/providers/profits/providers.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/dialogs/item_date_dialog.dart';
import 'package:money_tracker/providers/spends/providers.dart';

void showItemAddDialog(BuildContext context, String categoryId,
    [bool isProfit = false]) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
        actionsOverflowButtonSpacing: 10.0,
        content: AddItemWidget(
          categoryId: categoryId,
          isProfit: isProfit,
        ),
      );
    },
  );
}

class AddItemWidget extends ConsumerStatefulWidget {
  final String categoryId;
  final bool isProfit;
  const AddItemWidget(
      {super.key, required this.categoryId, required this.isProfit});

  @override
  ConsumerState<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends ConsumerState<AddItemWidget> {
  final nameController = TextEditingController();
  final costController = TextEditingController();
  String caption = '';
  String? costHelper;

  @override
  void initState() {
    super.initState();
    costHelper = S.current.dialogSpecifySum;
    if (widget.categoryId == '') {
      caption = S.current.dialogAddPlan;
    } else if (widget.isProfit) {
      caption = S.current.dialogAddProfit;
    } else {
      caption = S.current.dialogAddSpend;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dialogDate = ref.watch(dialogDateProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(caption),
                InkWell(
                  onTap: () async {
                    await showItemDateDialog(context, widget.categoryId == '');
                    setState(() {});
                  },
                  child: Text(
                    DateFormat(S.current.dateFormat).format(dialogDate),
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text(S.current.dialogName),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: costController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text(S.current.dialogAmount),
                  helperText: costHelper,
                  helperStyle: TextStyle(
                    color: costHelper == null ? Colors.black : Colors.red,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    costHelper =
                        value.isEmpty ? S.current.dialogSpecifySum : null;
                  });
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {
                final double? cost = double.tryParse(costController.text);
                if (cost != null && cost > 0) {
                  if (widget.categoryId == '') {
                    ref.read(firebasePlansControl.notifier).addPlan(
                        nameController.text,
                        costController.text,
                        Timestamp.fromDate(dialogDate.copyWith(
                            hour: DateTime.now().hour,
                            minute: DateTime.now().minute)));
                  } else {
                    widget.isProfit
                        ? ref.read(firebaseProfitsControl.notifier).addItem(
                            widget.categoryId,
                            nameController.text,
                            costController.text,
                            Timestamp.fromDate(dialogDate.copyWith(
                                hour: DateTime.now().hour,
                                minute: DateTime.now().minute)))
                        : ref.read(firebaseSpendsControl.notifier).addItem(
                            widget.categoryId,
                            nameController.text,
                            costController.text,
                            Timestamp.fromDate(dialogDate.copyWith(
                                hour: DateTime.now().hour,
                                minute: DateTime.now().minute)));
                  }

                  Navigator.of(context).pop(true);
                } else {
                  setState(() {
                    costHelper = S.current.dialogWrongAmount;
                  });
                }
              },
              child: Text(S.current.dialogAdd),
            ),
            Center(
              child: InkWell(
                onTap: () => Navigator.of(context).pop(false),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.current.dialogDiscard,
                    style:
                        const TextStyle(fontSize: 17.0, color: Colors.purple),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
