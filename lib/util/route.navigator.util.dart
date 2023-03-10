import 'package:flutter/material.dart';
import 'package:todo/pages/landing/landing.page.dart';

import '../pages/home/home.page.dart';
import '../pages/routes/home.page.route.dart';

class RouteNavigatorUtil {
  static Widget getRoute(String name) {
    switch (name) {
      case HomePage.routeName:
        return const HomePageRouting();
    }

    return const LandingPage();
  }

  static void previousPage({required BuildContext context, int seconds = 0}) {
    Future.delayed(Duration(seconds: seconds), () {
      Navigator.of(context).pop();
    });
  }

  static goToPage(
      {required BuildContext context,
      required String routeName,
      int seconds = 0}) {
    Future.delayed(Duration(seconds: seconds), () {
      // This callback will be executed after the SnackBar times out
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => getRoute(routeName),
        ),
      );
    });
  }
}
