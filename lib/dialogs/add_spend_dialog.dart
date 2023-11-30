import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/dialogs/spend_date_dialog.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/providers/providers.dart';

void showSpendAddDialog(BuildContext context, String categoryId) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
        actionsOverflowButtonSpacing: 10.0,
        content: AddSpendWidget(
          categoryId: categoryId,
        ),
      );
    },
  );
}

class AddSpendWidget extends ConsumerStatefulWidget {
  final String categoryId;
  const AddSpendWidget({super.key, required this.categoryId});

  @override
  ConsumerState<AddSpendWidget> createState() => _AddSpendWidgetState();
}

class _AddSpendWidgetState extends ConsumerState<AddSpendWidget> {
  final costController = TextEditingController();
  String? costHelper;

  @override
  void initState() {
    super.initState();
    costHelper = S.current.dialogSpecifyCons;
  }

  @override
  void dispose() {
    costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expDate = ref.watch(exploreDateProvider);
    final spendDate = ref.watch(spendDateProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.current.addSpend),
                InkWell(
                  onTap: () async {
                    if (spendDate == null) {
                      ref
                          .read(spendDateProvider.notifier)
                          .update((state) => expDate);
                    }
                    await showSpendDateDialog(context, spendDate ?? expDate);
                    setState(() {});
                  },
                  child: Text(
                    DateFormat(S.current.dateFormat)
                        .format(spendDate ?? expDate),
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: costController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text(S.current.dialogSpend),
                  helperText: costHelper,
                  helperStyle: TextStyle(
                    color: costHelper == null ? Colors.black : Colors.red,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    costHelper =
                        value.isEmpty ? S.current.dialogSpecifyText : null;
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
                  ref.read(firebaseSpendsControl.notifier).addSpend(
                      widget.categoryId,
                      costController.text,
                      Timestamp.fromDate(spendDate!.copyWith(
                          hour: DateTime.now().hour,
                          minute: DateTime.now().minute)));
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
