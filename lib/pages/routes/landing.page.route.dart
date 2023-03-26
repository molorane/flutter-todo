import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/landing/landing.page.dart';
import 'package:todo/pages/routes/home.page.route.dart';

class LandingPageRouting extends StatelessWidget {
  const LandingPageRouting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return HomePageRouting();
          } else {
            return LandingPage();
          }
        });
  }
}
