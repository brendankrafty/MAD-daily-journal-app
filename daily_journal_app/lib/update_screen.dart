import 'package:daily_journal_app/database_helper.dart';
import 'package:daily_journal_app/home_screen.dart';
import 'package:flutter/material.dart';

import 'entry_data.dart';
import 'main.dart';

class UpdateScreen extends StatefulWidget {
  final Entry? entry;
  final Function(Entry?) updateEntry;
  const UpdateScreen({super.key, this.entry, required this.updateEntry});
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.entry != null) {
      _titleController = TextEditingController(text: widget.entry!.etitle);
      _contentController = TextEditingController(text: widget.entry!.econtent);
    }

    super.initState();
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
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
          Expanded(
              child: ListView(
            children: [
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white, fontSize: 30),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Header',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
              ),
              TextField(
                controller: _contentController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLines: null,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Whats on your mind?',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
            ],
          )),
          ElevatedButton(
            onPressed: () {
              final title = _titleController.text;
              final content = _contentController.text;
              const mood = 10;
              final id = widget.entry?.id;
              if (title.isNotEmpty && content.isNotEmpty) {
                widget.updateEntry(Entry(
                    id: id,
                    etitle: title,
                    econtent: content,
                    emoodRating: mood));
              }
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.save),
          ),
        ]),
      ),
    );
  }
}
