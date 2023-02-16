import 'package:flutter/material.dart';
import 'package:todo/pages/landing/landing.page.dart';

import '../pages/home/home.page.dart';
import '../pages/routes/home.page.route.dart';

class RouteNavigatorUtil {
  static Widget getRoute(String name) {
    switch (name) {
      case Home.routeName:
        return const HomePageRouting();
    }

    return const LandingPage();
  }

  static toHomePage(
      {required BuildContext context,
      required String routeName,
      required int seconds}) {
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
