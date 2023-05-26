import 'package:flutter/material.dart';
import 'package:ipApp/Navigation/ontop_navigation_bar.dart';
import '../../Navigation/bottom_navigation_bar.dart';
import './body.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OnTopNavigationBar(),
      body: SingleChildScrollView(
        child: Body(),
      ),
      bottomNavigationBar: const ButtomNavigationBar(),
    );
  }
}
