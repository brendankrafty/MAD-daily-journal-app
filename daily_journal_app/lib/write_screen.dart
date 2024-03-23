import 'package:daily_journal_app/database_helper.dart';
import 'package:flutter/material.dart';
import 'entry_data.dart';
import 'main.dart';

DBHelper _dbHelper = DBHelper();

class WriteScreen extends StatefulWidget {
  final Entry? entry;
  final Function(Entry?) saveEntry;
  final Function(Entry?) updateEntry;
  final Function() onEntrySaved;
  const WriteScreen(
      {super.key,
        this.entry,
        required this.saveEntry,
        required this.updateEntry,
        required this.onEntrySaved});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _titleController = TextEditingController(text: widget.entry!.title);
      _contentController = TextEditingController(text: widget.entry!.content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  )
              )
            ],
          ),
          Expanded(
              child: ListView(
                children: [
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Describe your day in one word',
                        hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 22)
                    ),
                  ),
                  TextField(
                    controller: _contentController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Now whats on your mind?',
                        hintStyle: TextStyle(
                          color: Colors.blueGrey,
                        )),
                  ),
                ],
              )),
          FloatingActionButton(
            onPressed: () async {
              final title = _titleController.text;
              final content = _contentController.text;
              const mood = 10;
              final id = widget.entry?.id;
              if (title.isNotEmpty && content.isNotEmpty) {
                final newEntry = Entry(
                  id: id,
                  title: title,
                  content: content,
                  moodRating: mood,
                );
                if (widget.entry == null) {
                  await _dbHelper.createEntry(newEntry);
                } else {
                  await _dbHelper.updateEntry(newEntry);
                }
                Navigator.pop(context);
                widget.onEntrySaved();
              }
            },
            elevation: 10,
            backgroundColor: Colors.blueGrey,
            child: const Icon(Icons.save),
          ),
        ]),
      ),
    );
  }
}