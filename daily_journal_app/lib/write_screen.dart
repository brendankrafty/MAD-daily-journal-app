import 'package:flutter/material.dart';
import 'entry_data.dart';

class WriteScreen extends StatelessWidget {
  final Entry? entry;
  final Function(Entry?) saveEntry;
  final Function(Entry?) updateEntry;
  final Function() onEntrySaved;

  WriteScreen({
    this.entry,
    required this.saveEntry,
    required this.updateEntry,
    required this.onEntrySaved,
  });

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (entry != null) {
      _titleController.text = entry!.title;
      _contentController.text = entry!.content;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: Column(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          Expanded(
            child: ListView(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Describe your day in one word',
                  ),
                ),
                TextField(
                  controller: _contentController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Now whats on your mind?',
                  ),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              final title = _titleController.text;
              final content = _contentController.text;
              const mood = 10;
              final id = entry?.id;
              if (title.isNotEmpty && content.isNotEmpty) {
                final newEntry = Entry(
                  id: id,
                  title: title,
                  content: content,
                  moodRating: mood,
                );
                if (entry == null) {
                  saveEntry(newEntry);
                } else {
                  updateEntry(newEntry);
                }
                Navigator.pop(context);
                onEntrySaved();
              }
            },
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}