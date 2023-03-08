import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends ConsumerStatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends ConsumerState<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/profile/user.svg",
            press: () => {Navigator.of(context).pushNamed('/myAccount')},
          ),
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
            press: () {},
          ),
        ],
      ),
    );
  }
}
