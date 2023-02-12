import 'package:flutter/material.dart';
import 'package:todo/pages/dashboard/dashboard.page.dart';
import 'package:todo/pages/home/home.page.dart';
import 'package:todo/pages/profile/profile.page.dart';
import 'package:todo/pages/todo/update.todo.page.dart';
import 'package:todo/widgets/bottom.bar.dart';

import '../todo/add.todo.page.dart';

class HomePageRouting extends StatelessWidget {
  const HomePageRouting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomBar(),
        '/home': (context) => const Home(),
        '/dashboard': (context) => const DashboardPage(),
        '/profile': (context) => const ProfilePage(),
        '/addTodo': (context) => AddTodo(),
        '/updateTodo': (context) => UpdateTodo(),
      },
    );
  }
}
