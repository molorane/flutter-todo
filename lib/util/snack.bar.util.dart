import 'package:flutter/material.dart';

class SnackBarUtil {
  static void dismiss(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void cancelDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void snackBarWithDismiss(
      {required BuildContext context,
      required String value,
      required Function onPressed,
      required Function onVisible}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: (Colors.lightBlueAccent),
      duration: const Duration(seconds: 10),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Dismiss',
        onPressed: () => dismiss(context),
      ),
      onVisible: () => onVisible(),
    ));
  }

  static void snackBarWithUndo(
      {required BuildContext context,
      required String value,
      required Function onPressed,
      required Function onVisible}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: (Colors.lightBlueAccent),
      duration: const Duration(seconds: 10),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Undo',
        onPressed: () => onPressed(),
      ),
      onVisible: () => onVisible(),
    ));
  }
}
