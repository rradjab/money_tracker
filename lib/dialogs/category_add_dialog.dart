import 'dart:math';
import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:money_tracker/providers/profits/providers.dart';
import 'package:money_tracker/providers/spends/providers.dart';

void showCategoryAddDialog(BuildContext context,
    [bool isProfit = false]) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22.0))),
        contentPadding: const EdgeInsets.all(20.0),
        actionsPadding: const EdgeInsets.all(20.0),
        actionsOverflowButtonSpacing: 10.0,
        title: Center(child: Text(S.current.dialogAddCategory)),
        content: AddElementWidget(
          isProfit: isProfit,
        ),
      );
    },
  );
}

class AddElementWidget extends StatefulWidget {
  final bool isProfit;
  const AddElementWidget({super.key, required this.isProfit});

  @override
  State<AddElementWidget> createState() => _AddElementWidgetState();
}

class _AddElementWidgetState extends State<AddElementWidget> {
  String? colorHelper;
  String? nameHelper;
  bool showPicker = false;
  final nameController = TextEditingController();
  final colorController = TextEditingController();
  Color pickerColor = Color(Random().nextInt(0xffffffff)).withAlpha(0xff);

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      colorHelper = null;
      colorController.text = color.toString().substring(8, 16);
    });
  }

  @override
  void initState() {
    nameHelper = S.current.dialogSpecifyText;
    colorController.text = pickerColor.toString().substring(8, 16);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Text(S.current.dialogName),
                helperText: nameHelper,
                helperStyle: TextStyle(
                  color: nameHelper == null ? Colors.black : Colors.red,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  nameHelper =
                      value.isEmpty ? S.current.dialogSpecifyText : null;
                });
              },
            ),
          ),
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
          if (showPicker)
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
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(40),
                ),
                onPressed: () {
                  if (colorHelper == null && nameHelper == null) {
                    widget.isProfit
                        ? ref.read(firebaseProfitsControl.notifier).addCategory(
                            nameController.text, colorController.text)
                        : ref.read(firebaseSpendsControl.notifier).addCategory(
                            nameController.text, colorController.text);
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text(S.current.dialogAdd),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: InkWell(
              onTap: () => Navigator.of(context).pop(false),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.current.dialogDiscard,
                  style: const TextStyle(fontSize: 17.0, color: Colors.purple),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
