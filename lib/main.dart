import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/landing.page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingPage(),
      },
    );
  }
}
