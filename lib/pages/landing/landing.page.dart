import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/auth/login.page.dart';
import 'package:todo/pages/gettingstarted/how.to.guides.dart';

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
                    closedElevation: 0,
                    transitionDuration: Duration(seconds: 1),
                    closedBuilder: (
                      BuildContext context,
                      VoidCallback action,
                    ) {
                      return Container(
                        height: 58,
                        padding: EdgeInsets.only(
                          left: 56.0,
                          right: 56.0,
                          top: 16,
                          bottom: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38.0),
                          color: Colors.blue,
                        ),
                        child: Text(
                          "Getting Started",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    openBuilder: (builder, context) {
                      return HowToGuides();
                    }),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                    height: 58,
                    width: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8 + 32),
                      color: Color(0xff132137),
                    ),
                    child: InkWell(
                      onTap: () => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ))
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.login, color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
