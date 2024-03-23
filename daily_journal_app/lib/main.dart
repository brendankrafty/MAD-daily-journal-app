import 'package:flutter/material.dart';
import 'mood_screen.dart';
import 'write_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomScaffold(
        selectedIndex: 0,
        body: Text('Home'),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class CustomScaffold extends StatefulWidget {
  final int selectedIndex;
  final Widget body;

  CustomScaffold({required this.selectedIndex, required this.body});

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  int _selectedIndex = 0;

  final _screens = [
    MoodScreen(),
    HomeScreen(),
    WriteScreen(
      saveEntry: (entry) {
        // Implement saveEntry function here
      },
      updateEntry: (entry) {
        // Implement updateEntry function here
      },
      onEntrySaved: () {
        // Implement onEntrySaved function here
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      backgroundColor: Colors.white70,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
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
          if (index != _selectedIndex) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}