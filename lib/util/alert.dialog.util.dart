import 'package:flutter/material.dart';

class AlertDialogUtil {
  static void cancelDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static Widget cancelButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () => cancelDialog(context),
      child: const Text("Cancel"),
    );
  }

  static Widget continueButton(BuildContext context, Function onPressed) {
    return ElevatedButton(
      child: const Text("Yes"),
      onPressed: () => onPressed(),
    );
  }

  static void showAlertDialog(final BuildContext context, final int taskId,
      final String title, final String message, final Function onContinue) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        cancelButton(context),
        ElevatedButton(
          child: const Text("Yes"),
          onPressed: () => onContinue(taskId, context),
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
