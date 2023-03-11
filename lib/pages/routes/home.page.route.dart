import 'package:flutter/material.dart';
import 'package:todo/widgets/bottom.bar.dart';

class HomePageRouting extends StatelessWidget {
  const HomePageRouting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => const BottomBar()},
    );
  }
}
