import 'package:flutter/material.dart';

import 'error.object.dart';

class ErrorDialog extends StatelessWidget {
  static const String routeName = "/error";

  final ErrorObject errorObject;

  const ErrorDialog({
    Key? key,
    required this.errorObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 350,
        width: 350,
        decoration: const BoxDecoration(
            color: Color(0xffffdbd9),
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: Color(0x10000000),
                spreadRadius: 3,
                offset: Offset(3, 3),
                blurRadius: 3,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 70),
              const SizedBox(height: 20),
              Text(
                errorObject.title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 0.0,
                    color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                errorObject.message,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
