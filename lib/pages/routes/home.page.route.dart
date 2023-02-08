import 'package:flutter/material.dart';
import 'package:todo/pages/add.todo.page.dart';
import 'package:todo/pages/dashboard.page.dart';
import 'package:todo/pages/home.page.dart';
import 'package:todo/pages/profile.page.dart';
import 'package:todo/pages/update.todo.page.dart';
import 'package:todo/widgets/bottom.bar.dart';

class HomePageRouting extends StatefulWidget {
  const HomePageRouting({Key? key}) : super(key: key);

  @override
  State<HomePageRouting> createState() => _HomePageRoutingState();
}

class _HomePageRoutingState extends State<HomePageRouting> {
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
        '/addTodo': (context) => const AddTodo(),
        '/updateTodo': (context) => const UpdateTodo(),
      },
    );
  }
}
