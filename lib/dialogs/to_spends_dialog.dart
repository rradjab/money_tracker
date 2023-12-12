import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker/models/plan_model.dart';
import 'package:money_tracker/providers/plans/providers.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:money_tracker/dialogs/item_date_dialog.dart';
import 'package:money_tracker/providers/spends/providers.dart';

void showToSpendsAddDialog(BuildContext context, PlanModel model) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
        actionsOverflowButtonSpacing: 10.0,
        content: ToSpendsWidget(model: model),
      );
    },
  );
}

class ToSpendsWidget extends ConsumerStatefulWidget {
  final PlanModel model;
  const ToSpendsWidget({super.key, required this.model});

  @override
  ConsumerState<ToSpendsWidget> createState() => _ToSpendsWidgetState();
}

class _ToSpendsWidgetState extends ConsumerState<ToSpendsWidget> {
  final nameController = TextEditingController();
  final costController = TextEditingController();
  final colorController = TextEditingController();
  final remainderController = TextEditingController();
  final categoryController = TextEditingController();
  String? costHelper;
  String? colorHelper;
  String? categoryHelper;
  bool showPicker = false;
  bool newCategory = false;
  Color pickerColor = Color(Random().nextInt(0xffffffff)).withAlpha(0xff);

  @override
  void initState() {
    super.initState();
    categoryHelper = S.current.dialogSpecifyCategory;
    costController.text = widget.model.cost.toString();
    colorController.text = pickerColor.toString().substring(8, 16);
  }

  @override
  void dispose() {
    nameController.dispose();
    costController.dispose();
    colorController.dispose();
    categoryController.dispose();
    remainderController.dispose();
    super.dispose();
  }

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      colorHelper = null;
      colorController.text = color.toString().substring(8, 16);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dialogDate = ref.watch(dialogDateProvider);
    final categories = <CategoryModel>[
      ...ref.watch(spendsCategoriesStreamProvider).value == null
          ? []
          : ref.watch(spendsCategoriesStreamProvider).value!.toList()
    ];

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.current.dialogIsRealised),
                InkWell(
                  onTap: () async {
                    await showItemDateDialog(context);
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
              child: DropdownSearch<String>(
                items: [
                  S.current.dialogNewCategory,
                  ...categories.map((e) => e.name.toString()),
                ],
                onChanged: (value) {
                  newCategory = value == S.current.dialogNewCategory;
                  categoryController.text = value == S.current.dialogNewCategory
                      ? ''
                      : value.toString();
                  categoryHelper = null;
                  setState(() {});
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    helperText: newCategory ? null : categoryHelper,
                  ),
                ),
              ),
            ),
            if (newCategory)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(S.current.dialogCategory),
                    helperText: categoryHelper,
                    helperStyle: TextStyle(
                      color: categoryHelper == null ? Colors.black : Colors.red,
                    ),
                  ),
                  onChanged: (value) {
                    categoryHelper =
                        value == '' ? S.current.dialogSpecifyCategory : null;
                    setState(() {});
                  },
                ),
              ),
            if (newCategory)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: colorController,
                  maxLength: 8,
                  onTap: () {
                    setState(() => showPicker = false);
                  },
                  onChanged: (value) {
                    try {
                      colorHelper = null;
                      pickerColor = Color(int.parse('0x$value'));
                    } catch (e) {
                      colorHelper = S.current.dialogWrongColor;
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => showPicker = !showPicker);
                      },
                      icon: Container(
                        color: Colors.black,
                        child: Icon(
                          Icons.square,
                          color: pickerColor,
                        ),
                      ),
                    ),
                    label: Text(S.current.dialogSpecifyColor),
                    helperText: colorHelper,
                    helperStyle: TextStyle(
                      color: colorHelper == null ? Colors.black : Colors.red,
                    ),
                  ),
                ),
              ),
            if (newCategory && showPicker)
              ColorPicker(
                color: pickerColor,
                onColorChanged: changeColor,
                pickersEnabled: const <ColorPickerType, bool>{
                  ColorPickerType.both: false,
                  ColorPickerType.primary: false,
                  ColorPickerType.accent: false,
                  ColorPickerType.bw: false,
                  ColorPickerType.custom: false,
                  ColorPickerType.wheel: true,
                },
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
                    final double? val = double.tryParse(value.toString());
                    final double cost = widget.model.cost ?? 0;
                    if (val != null) {
                      remainderController.text =
                          ((cost - val) >= 0 ? cost - val : 0).toString();
                    }
                    costHelper =
                        value.isEmpty ? S.current.dialogSpecifySum : null;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: remainderController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text(S.current.dialogRemainder),
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
              onPressed: () async {
                final double? cost = double.tryParse(costController.text);
                final remainderCost =
                    double.tryParse(remainderController.text) ?? 0;

                String categoryid = '';
                if (cost != null && cost > 0 && categoryController.text != '') {
                  if (!categories.any(
                      (element) => element.name == categoryController.text)) {
                    categoryid = await ref
                        .read(firebaseSpendsControl.notifier)
                        .addCategory(
                            categoryController.text, colorController.text);
                  } else {
                    categoryid = categories
                            .firstWhere((element) =>
                                element.name == categoryController.text)
                            .id ??
                        '';
                  }

                  if (categoryid.isNotEmpty) {
                    ref.read(firebaseSpendsControl.notifier).addItem(
                        categoryid,
                        nameController.text,
                        costController.text,
                        Timestamp.fromDate(dialogDate.copyWith(
                            hour: DateTime.now().hour,
                            minute: DateTime.now().minute)));
                  }

                  if (remainderCost > 0) {
                    ref
                        .read(firebasePlansControl.notifier)
                        .updatePlan(widget.model.id.toString(), remainderCost);
                  } else {
                    ref
                        .read(firebasePlansControl.notifier)
                        .deletePlan(widget.model.id.toString());
                  }

                  if (context.mounted) Navigator.of(context).pop(true);
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
