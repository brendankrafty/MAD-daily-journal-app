import 'dart:math';
import 'package:daily_journal_app/database_helper.dart';
import 'package:flutter/material.dart';
import 'entry_data.dart';
import 'main.dart';

DBHelper _dbHelper = DBHelper();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Entry>> _entryList;

  // List of inspirational quotes
  final List<String> quotes = [
    "The only way to do great work is to love what you do.",
    "Believe you can and you're halfway there.",
    "Don't watch the clock; do what it does. Keep going.",
    "The future belongs to those who believe in the beauty of their dreams.",
  ];

  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _updateEntryList();
  }

  _updateEntryList() {
    setState(() {
      _entryList = DBHelper().readAllEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    int quoteIndex = random.nextInt(quotes.length);
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _entryList,
                builder: (context, AsyncSnapshot<List<Entry>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    padding: const EdgeInsets.only(top: 30),
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(snapshot.data![index].title ?? ''),
                          subtitle: Text(snapshot.data![index].content ?? ''),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // Display the random quote at the bottom of the screen
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                quotes[quoteIndex],
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
      ),
    );
  }
}