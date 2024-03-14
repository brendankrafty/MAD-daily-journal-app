import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'entry_data.dart';

class WriteScreen extends StatefulWidget {
  final Entry? entry;
  const WriteScreen({super.key, this.entry});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.entry != null) {
      _titleController = TextEditingController(text: widget.entry!.title);
      _contentController = TextEditingController(text: widget.entry!.content);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
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
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
              context, [_titleController.text, _contentController.text]);
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.save),
      ),
      bottomNavigationBar: const GNav(
          backgroundColor: Colors.black,
          gap: 8,
          color: Colors.white,
          activeColor: Colors.white,
          padding: EdgeInsets.all(16),
          tabs: [
            GButton(
              icon: Icons.add_chart,
              text: 'Dayz Data',
            ),
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.add_box_outlined,
              text: 'Add',
            )
          ]),
    );
  }
}
