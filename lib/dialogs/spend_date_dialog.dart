import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/providers.dart';

Future<void> showSpendDateDialog(BuildContext context, DateTime date) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        contentPadding: const EdgeInsets.all(0),
        actionsOverflowButtonSpacing: 10.0,
        content: SpenDatedWidget(
          date: date,
        ),
      );
    },
  );
}

class SpenDatedWidget extends ConsumerStatefulWidget {
  final DateTime date;
  const SpenDatedWidget({super.key, required this.date});

  @override
  ConsumerState<SpenDatedWidget> createState() => _SpenDatedWidgetState();
}

class _SpenDatedWidgetState extends ConsumerState<SpenDatedWidget> {
  final dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = DateFormat(S.current.dateFormat).format(widget.date);
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expDate = ref.watch(exploreDateProvider);
    final spendDate = ref.watch(spendDateProvider);
    final spendDateRef = ref.read(spendDateProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
              top: 22.0, bottom: 22.0, left: 10.0, right: 10.0),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 22.0, right: 22.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.current.dialogSelectDate),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.yMMMEd().format(spendDate ?? expDate),
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: spendDate ?? expDate,
                          firstDate: DateTime(1900, 12, 10),
                          lastDate: DateTime.now(),
                        );
                        if (dateTime != null && context.mounted) {
                          dateController.text = DateFormat(S.current.dateFormat)
                              .format(dateTime)
                              .toString();
                          ref
                              .read(spendDateProvider.notifier)
                              .update((state) => dateTime);
                        }
                      },
                      child: const Icon(Icons.calendar_today),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 30.0, right: 30.0, top: 15.0, bottom: 20.0),
          child: Column(
            children: [
              TextField(
                controller: dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  label: Text(S.current.dialogDate),
                  labelStyle: const TextStyle(color: Colors.grey),
                  helperText:
                      spendDate == null ? S.current.dialogIncorrectDate : null,
                  helperStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: (value) {
                  DateFormat dateFormat = DateFormat(S.current.dateFormat);
                  try {
                    if (dateFormat.parse(value).isAfter(DateTime.now()) ||
                        dateFormat.parse(value).isBefore(DateTime(1900))) {
                      spendDateRef.update((state) => null);
                    } else {
                      spendDateRef.update((state) => dateFormat.parse(value));
                    }
                  } catch (e) {
                    spendDateRef.update((state) => null);
                  }
                },
              ),
              const SizedBox(height: 30),
              Consumer(builder: (context, ref, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size.fromHeight(40),
                  ),
                  onPressed: () {
                    DateFormat dateFormat = DateFormat(S.current.dateFormat);

                    try {
                      if (dateFormat
                              .parse(dateController.text)
                              .isAfter(DateTime.now()) ||
                          dateFormat
                              .parse(dateController.text)
                              .isBefore(DateTime(1900))) {
                        spendDateRef.update((state) => expDate);
                        dateController.text =
                            DateFormat(S.current.dateFormat).format(expDate);
                      } else {
                        spendDateRef.update(
                            (state) => dateFormat.parse(dateController.text));
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      spendDateRef.update((state) => expDate);
                      dateController.text =
                          DateFormat(S.current.dateFormat).format(expDate);
                    }
                  },
                  child: Text(S.current.dialogConfirm),
                );
              }),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.current.dialogDiscard,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
