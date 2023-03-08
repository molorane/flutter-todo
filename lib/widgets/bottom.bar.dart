// ignore_for_file: prefer_const_constructors, camel_case_types,prefer_const_literals_to_create_immutables
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo/pages/home/home.page.dart';
import 'package:todo/pages/profile/profile.page.dart';
import 'package:todo/theme/colors.dart';

import '../pages/dashboard/dashboard.page.dart';
import '../pages/menu/menu.page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<BottomBar> {
  int currentIndex = 0;

  final screens = [
    HomePage(),
    DashboardPage(),
    MenuPage(),
    ProfilePage(),
  ];

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: inProgressTaskContainer,
          color: navBar,
          index: currentIndex,
          onTap: (index) => changeIndex(index),
          items: [
            Icon(
              Icons.task,
              color: Colors.white,
            ),
            Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            Icon(
              Icons.menu,
              color: Colors.white,
            ),
            Icon(
              Iconsax.profile_tick4,
              color: Colors.white,
            )
          ]),
    );
  }
}
