import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/auth/login.page.dart';
import 'package:todo/widgets/bottom.bar.dart';

import '../gettingstarted/how.to.guides.dart';
import '../task/grouping/tasks.by.type.page.dart';

class HomePageRouting extends StatelessWidget {
  const HomePageRouting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              routes: {
                '/': (context) => const BottomBar(),
                '/tasksByType': (context) => TasksByType(),
                '/howToGuides': (context) => HowToGuides()
              },
            );
          } else {
            return LoginPage();
          }
        });
  }
}
