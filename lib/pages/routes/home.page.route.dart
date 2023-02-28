import 'package:flutter/material.dart';
import 'package:todo/pages/dashboard/dashboard.page.dart';
import 'package:todo/pages/home/home.page.dart';
import 'package:todo/pages/profile/profile.page.dart';
import 'package:todo/pages/todo/update.todo.page.dart';
import 'package:todo/widgets/bottom.bar.dart';

import '../todo/add.todo.page.dart';
import '../todo/grouping/todos.by.type.page.dart';
import '../todo/search.todos.page.dart';

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
        '/addTodo': (context) => AddTodo(),
        '/updateTodo': (context) => const UpdateTodo(),
        '/todosByType': (context) => TodosByType(),
        '/searchTodos': (context) => SearchTodos()
      },
    );
  }
}
