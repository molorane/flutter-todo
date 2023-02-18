import 'package:flutter/material.dart';
import 'package:todo/theme/colors.dart';

import '../../util/route.navigator.util.dart';
import '../home/home.page.dart';
import 'error.object.dart';

class ErrorDialog extends StatelessWidget {
  static const String routeName = "/error";

  const ErrorDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ErrorObject errorObject =
        ModalRoute.of(context)!.settings.arguments as ErrorObject;
    return MaterialApp(
      title: "Error Page",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Error Page"),
        ),
        body: Center(
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
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_outlined,
                                color: inactiveButton),
                            SizedBox(
                              width: 2,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                      color: inactiveButton,
                                      fontFamily: "Cerebri Sans",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                ))
                          ],
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(color: inactiveButton),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home, color: inactiveButton),
                            SizedBox(
                              width: 2,
                            ),
                            GestureDetector(
                                onTap: () {
                                  RouteNavigatorUtil.goToPage(
                                      context: context,
                                      routeName: Home.routeName);
                                },
                                child: Text(
                                  "Home",
                                  style: TextStyle(
                                      color: inactiveButton,
                                      fontFamily: "Cerebri Sans",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                ))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
