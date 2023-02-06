import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/add.todo.page.dart';
import 'package:todo/pages/home.page.dart';
import 'package:todo/pages/profile.page.dart';
import 'package:todo/pages/update.todo.page.dart';
import 'package:todo/widgets/bottom.bar.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomBar(),
        '/home': (context) => const HomePage(),
        //'/dashboard': (context) => const DashboardPage(),
        '/profile': (context) => const ProfilePage(),
        '/addTodo': (context) => const AddTodo(),
        '/updateTodo': (context) => const UpdateTodo(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomBar(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
