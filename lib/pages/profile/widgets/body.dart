import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../routes/landing.page.route.dart';
import '../account.info.page.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          const SizedBox(height: 20),
          OpenContainer(
              transitionType: ContainerTransitionType.fadeThrough,
              closedColor: Colors.transparent,
              closedElevation: 0,
              transitionDuration: Duration(seconds: 1),
              closedBuilder: (
                BuildContext context,
                VoidCallback action,
              ) {
                return ProfileMenu(
                  text: "My Account",
                  icon: "assets/profile/user.svg",
                  press: action,
                );
              },
              openBuilder: (builder, context) {
                return AccountInfoPage();
              }),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/profile/bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/profile/settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/profile/help.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/profile/logout.svg",
            press: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LandingPageRouting(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
