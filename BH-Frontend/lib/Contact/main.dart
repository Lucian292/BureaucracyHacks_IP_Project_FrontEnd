import 'package:flutter/material.dart';
import 'package:ipApp/Navigation/ontop_navigation_bar.dart';
import '../Navigation/bottom_navigation_bar.dart';
import './body.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppBarExample(),
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff293441),
      appBar: const OnTopNavigationBar(),
      body: Body(),

      bottomNavigationBar: const ButtomNavigationBar(),
    );
  }
}
