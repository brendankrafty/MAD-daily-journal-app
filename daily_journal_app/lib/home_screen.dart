import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'entry_data.dart';
import 'main.dart';
import 'write_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Database _database;
  List<Map<String, dynamic>> _entrys = [];
  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    // Database _database = dbhelp.db as Database;
    //_refreshNotes();
  }

  Future<void> _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'entry_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE entry(id INTEGER PRIMARY KEY, title TEXT, content TEXT, mood INT)',
        );
      },
      version: 1,
    );
    _refreshNotes();
  }

  Future<void> _insertNote(Entry? note) async {
    await _database.insert(
      'notes',
      note!.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _refreshNotes();
  }

  Future<void> _updateNote(Entry? note) async {
    await _database.update(
      'notes',
      note!.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    _refreshNotes();
  }

  Future<void> _refreshNotes() async {
    final List<Map<String, dynamic>> notes = await _database.query('notes');
    setState(() {
      _entrys = notes;
    });
  }

  Future<void> _deleteNote(int? id) async {
    await _database.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    _refreshNotes();
  }

  // DBHelper dbhelp = DBHelper();
  // late int length = entryLength() as int;
  // late List<Entry> _entry = getEntries() as List<Entry>;
  // late List<Map<String, dynamic>> _entries =
  //     dbhelp.refreshNotes() as List<Map<String, dynamic>>;

  // Future<int> entryLength() async {
  //   List<Entry> entries = await dbhelp.getEntries();
  //   length = entries.length;
  //   return length;
  // }

  // Future<List<Entry>> getEntries() async {
  //   List<Entry> entries = await dbhelp.getEntries();
  //   return entries;
  // }

  // Future<void> _refreshNotes() async {
  //   final List<Entry> entry = await dbhelp.getEntries();
  //   setState(() {
  //     _entry = entry;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      selectedIndex: 1,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.grey.shade800,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    padding: const EdgeInsets.all(0),
                    icon: Container(
                      width: 35,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.sort,
                        color: Colors.grey,
                      ),
                    ))
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _entrys.length,
              padding: const EdgeInsets.only(top: 30),
              itemBuilder: (context, index) {
                return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    color: Colors.white70,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => WriteScreen(
                                entry: Entry(
                                    id: _entrys[index]['id'],
                                    etitle: _entrys[index]['title'],
                                    econtent: _entrys[index]['content'],
                                    emoodRating: _entrys[index]['mood']),
                                saveEntry: _insertNote,
                                updateEntry: _updateNote,
                              ),
                            ),
                          );
                        },
                        title: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: _entrys[index]['title'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.5),
                              children: [
                                TextSpan(
                                  text: _entrys[index]['content'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      height: 1.5),
                                )
                              ]),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            DateTime.now() as String,
                            style: const TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            _deleteNote(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ));
              },
            )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  // void deleteNote(int index) {
  //   setState(() {
  //     Entry entry = sampleEntry[index];
  //     sampleEntry.remove(entry);
  //   });
}
