import 'package:daily_journal_app/splash.dart';
import 'package:daily_journal_app/write_screen.dart';
import 'package:flutter/material.dart';
import 'package:daily_journal_app/home_screen.dart';
import 'package:daily_journal_app/mood_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/mood': (context) => MoodScreen(),
        '/write': (context) => WriteScreen(
              saveEntry: (entry) {
                // Provide saveEntry function here
              },
            ),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
      ),
    );
  }
}

class CustomScaffold extends StatefulWidget {
  final Widget body;

  const CustomScaffold({super.key, required this.body});

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      backgroundColor: Colors.white70,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Mood Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'New Entry',
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/mood');
              break;
            case 1:
              Navigator.pushNamed(context, '/home');
              break;
            case 2:
              Navigator.pushNamed(context, '/write');
              break;
          }
        },
      ),
    );
  }
}
