import 'package:flutter/material.dart';

class SnackBarUtil {
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
        onPressed: onPressed(),
      ),
      onVisible: onVisible(),
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
