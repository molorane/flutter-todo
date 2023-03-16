import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class AwesomeDialogUtil {
  static void warning(final BuildContext context, final int taskId,
      final String title, final String message, final Function onContinue) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.warning,
      btnOkText: "Yes",
      btnOkColor: CupertinoColors.destructiveRed,
      title: title,
      desc: message,
      btnCancelColor: CupertinoColors.activeOrange,
      btnOkOnPress: () => onContinue(taskId, context),
      btnCancelOnPress: () {},
    ).show();
  }

  static void success(
      final BuildContext context, final String title, final String message) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.success,
      btnOkText: "Ok",
      title: title,
      desc: message,
      btnOkOnPress: () => {},
    ).show();
  }

  static void successOnAction(
      {required BuildContext context,
      required String title,
      required String message,
      required Function onVisible}) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.success,
      btnOkText: "Ok",
      title: title,
      desc: message,
      btnOkOnPress: () => onVisible(context),
    ).show();
  }
}
