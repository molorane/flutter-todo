import 'package:flutter/material.dart';

class AlertDialogConfirm extends StatelessWidget {
  final String message;

  const AlertDialogConfirm({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("AlertDialog"),
      content: Text(message),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Continue"),
          onPressed: () {},
        ),
      ],
    );
  }
}
