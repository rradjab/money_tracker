import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';

Future<bool> confirmDismiss(BuildContext context) async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.current.confirmDelete),
        content: Text(
          S.current.dialogDeleteAnswer,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(S.current.delete)),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(S.current.dialogDiscard),
          ),
        ],
      );
    },
  );
}
