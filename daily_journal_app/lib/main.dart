import 'package:daily_journal_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:daily_journal_app/home_screen.dart';
import 'package:daily_journal_app/mood_screen.dart';
import 'package:daily_journal_app/write_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/mood': (context) => const MoodScreen(),
        '/write': (context) => const WriteScreen(),
      },
    );
  }
}

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final int selectedIndex;

  const CustomScaffold({Key? key, required this.body, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: make background color changeable per page needs
      backgroundColor: const Color.fromARGB(143, 224, 222, 222),
      body: body,
      bottomNavigationBar: GNav(
        backgroundColor: Colors.black,
        gap: 8,
        color: Colors.white,
        activeColor: Colors.white,
        padding: EdgeInsets.all(16),
        tabs: [
          GButton(
            icon: Icons.add_chart,
            text: 'Dayz Data',
            onPressed: () {
              Navigator.pushNamed(context, '/mood');
            },
          ),
          GButton(
            icon: Icons.home,
            text: 'Home',
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
            onPressed: () {
              // Add your navigation code here
            },
          ),
          GButton(
            icon: Icons.add_box_outlined,
            text: 'Add',
            onPressed: () {
              Navigator.pushNamed(context, '/write');
            },
          )
        ],
      ),
    );
  }
}