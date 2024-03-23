import 'package:flutter/material.dart';
import 'entry_data.dart';

class HomeScreen extends StatelessWidget {
  final List<String> quotes = [
    "The only way to do great work is to love what you do.",
    "Believe you can and you're halfway there.",
    "Don't watch the clock; do what it does. Keep going.",
    "The future belongs to those who believe in the beauty of their dreams.",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: quotes.length,
              padding: const EdgeInsets.only(top: 30),
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(quotes[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              quotes[0],
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}