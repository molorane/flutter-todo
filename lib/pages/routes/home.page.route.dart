import 'package:flutter/material.dart';
import 'package:todo/pages/dashboard/dashboard.page.dart';
import 'package:todo/pages/home/home.page.dart';
import 'package:todo/pages/profile/profile.page.dart';
import 'package:todo/widgets/bottom.bar.dart';

import '../task/add.task.page.dart';
import '../task/grouping/tasks.by.type.page.dart';
import '../task/search.task.page.dart';
import '../task/update.task.page.dart';

class HomePageRouting extends StatelessWidget {
  const HomePageRouting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomBar(),
        '/home': (context) => HomePage(),
        '/dashboard': (context) => DashboardPage(),
        '/profile': (context) => const ProfilePage(),
        '/addTask': (context) => const AddTask(),
        '/updateTask': (context) => const UpdateTask(),
        '/tasksByType': (context) => TasksByType(),
        '/searchTasks': (context) => const SearchTasks()
      },
    );
  }
}
