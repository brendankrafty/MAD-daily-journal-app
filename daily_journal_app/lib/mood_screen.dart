import 'package:flutter/material.dart';

import 'main.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({Key? key}) : super(key: key);

  @override
  _MoodScreenState createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      selectedIndex: 0,
      body: Center(child: Text('Mood Screen')),
    );
  }
}