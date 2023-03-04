// ignore_for_file: prefer_const_constructors, camel_case_types,prefer_const_literals_to_create_immutables
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primary,
        unselectedItemColor: inactiveButton,
        iconSize: 20,
        selectedIconTheme: IconThemeData(size: 25),
        selectedLabelStyle: TextStyle(
            fontFamily: 'Cerebri Sans',
            fontWeight: FontWeight.w700,
            fontSize: 13),
        unselectedLabelStyle:
            TextStyle(fontFamily: 'Cerebri Sans', fontSize: 13),
        onTap: (index) => setState(() => currentIndex = index),
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.task),
              icon: Icon(Icons.task),
              label: 'Tasks'),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.dashboard_customize_rounded),
              icon: Icon(Icons.dashboard),
              label: 'Dashboard'),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.menu_open_sharp),
              icon: Icon(Icons.menu),
              label: 'Menu'),
          BottomNavigationBarItem(
            activeIcon: Icon(Iconsax.profile_tick5),
            icon: Icon(Iconsax.profile_tick4),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
