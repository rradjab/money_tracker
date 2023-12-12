import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/providers.dart';

Future<void> showItemDateDialog(BuildContext context,
    [bool isPlan = false]) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        contentPadding: const EdgeInsets.all(0),
        actionsOverflowButtonSpacing: 10.0,
        content: ItemDateWidget(
          isPlan: isPlan,
        ),
      );
    },
  );
}

class ItemDateWidget extends ConsumerStatefulWidget {
  final bool isPlan;
  const ItemDateWidget({super.key, required this.isPlan});

  @override
  ConsumerState<ItemDateWidget> createState() => _ItemDatedWidgetState();
}

class _ItemDatedWidgetState extends ConsumerState<ItemDateWidget> {
  final dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dialogDate = ref.watch(dialogDateProvider);
    final dialogDateState = ref.read(dialogDateProvider.notifier);
    dateController.text = DateFormat(S.current.dateFormat).format(dialogDate);

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
                      DateFormat.yMMMEd().format(dialogDate),
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () async {
                        final initialDate = DateTime.now().day == dialogDate.day
                            ? dialogDate.copyWith(day: dialogDate.day + 1)
                            : dialogDate;

                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: widget.isPlan ? initialDate : dialogDate,
                          firstDate: widget.isPlan
                              ? DateTime.now()
                                  .copyWith(day: DateTime.now().day + 1)
                              : DateTime(1900, 12, 10),
                          lastDate: widget.isPlan
                              ? DateTime.now()
                                  .copyWith(year: DateTime.now().year + 100)
                              : DateTime.now(),
                        );
                        if (dateTime != null && context.mounted) {
                          dateController.text = DateFormat(S.current.dateFormat)
                              .format(dateTime)
                              .toString();
                          ref
                              .read(dialogDateProvider.notifier)
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
                  helperStyle: const TextStyle(color: Colors.red),
                ),
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
                      if (widget.isPlan) {
                        if (dateFormat
                            .parse(dateController.text)
                            .isAfter(DateTime.now())) {
                          dialogDateState.update(
                              (state) => dateFormat.parse(dateController.text));
                          Navigator.of(context).pop();
                        }
                      } else {
                        if (!dateFormat
                                .parse(dateController.text)
                                .isAfter(DateTime.now()) &&
                            !dateFormat
                                .parse(dateController.text)
                                .isBefore(DateTime(1900))) {
                          dialogDateState.update(
                              (state) => dateFormat.parse(dateController.text));
                          Navigator.of(context).pop();
                        }
                      }
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                    }
                    dateController.text = DateFormat(S.current.dateFormat)
                        .format(ref.watch(dialogDateProvider));
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
