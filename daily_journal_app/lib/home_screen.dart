import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'entry_data.dart';
import 'write_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(143, 224, 222, 222),
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
              itemCount: sampleEntry.length,
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
                              builder: (BuildContext context) =>
                                  WriteScreen(entry: sampleEntry[index]),
                            ),
                          );
                        },
                        title: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: '${sampleEntry[index].title} \n',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.5),
                              children: [
                                TextSpan(
                                  text: sampleEntry[index].content,
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
                            DateFormat('EEE MMM d, yyyy h:mm a')
                                .format(sampleEntry[index].modifiedTime),
                            style: const TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            deleteNote(index);
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

  void deleteNote(int index) {
    setState(() {
      Entry entry = sampleEntry[index];
      sampleEntry.remove(entry);
    });
  }
}
