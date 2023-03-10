import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/auth/login.page.dart';
import 'package:todo/pages/gettingstarted/how.to.guides.dart';

import '../../theme/colors.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/landing.png',
                  width: 300,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'Todo App',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Track Your Tasks'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Bebas',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                const Text(
                  'This is a todo application build to help me manage my daily tasks. These includes studying, workouts, prayer. This '
                  'app is only for learning purpose as I am upskilling on flutter.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    closedColor: navBar,
                    closedElevation: 0,
                    transitionDuration: Duration(seconds: 1),
                    closedBuilder: (
                      BuildContext context,
                      VoidCallback action,
                    ) {
                      return MaterialButton(
                        onPressed: action,
                        minWidth: double.infinity,
                        height: 50,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text(
                          'Get Started'.toUpperCase(),
                        ),
                      );
                    },
                    openBuilder: (builder, context) {
                      return HowToGuides();
                    }),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  minWidth: double.infinity,
                  height: 50,
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Sign In'.toUpperCase(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
