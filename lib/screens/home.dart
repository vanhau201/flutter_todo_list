import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/models/note.dart';
import 'package:todo_list/screens/edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];
  bool sorted = false;
  @override
  void initState() {
    super.initState();
    notes = sampleNotes;
  }

  Color _getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void _handleDelete(String id) {
    setState(() {
      // notes.removeWhere((element) => element.id == id);
      sampleNotes.removeWhere((element) => element.id == id);
    });
  }

  void _handleSearch(String textSearch) {
    setState(() {
      notes = sampleNotes
          .where((note) =>
              note.title.toLowerCase().contains(textSearch) ||
              note.content.toLowerCase().contains(textSearch))
          .toList();
    });
  }

  void _handleSort() {
    if (sorted) {
      setState(() {
        notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
      });
    } else {
      setState(() {
        notes.sort((a, b) => b.modifiedTime.compareTo(a.modifiedTime));
      });
    }
    sorted = !sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 40, right: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Notes",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: _handleSort,
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                _handleSearch(value);
              },
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(right: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "Search notes...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.grey.shade800,
                filled: true,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    color: _getRandomColor(),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute<Note>(
                              builder: (BuildContext context) =>
                                  EditScreen(note: notes[index]),
                            ));
                        if (result != null) {
                          setState(() {
                            final indexOld = sampleNotes.indexOf(notes[index]);
                            sampleNotes[indexOld] = Note(
                                id: result.id,
                                title: result.title,
                                content: result.content,
                                modifiedTime: result.modifiedTime);
                          });
                        }
                      },
                      title: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: "${notes[index].title} \n",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.5),
                              children: [
                                TextSpan(
                                    text: notes[index].content,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        height: 1.5))
                              ])),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(notes[index].modifiedTime)}",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 10,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            final result = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey.shade900,
                                  icon: const Icon(Icons.info,
                                      color: Colors.white),
                                  title: const Text(
                                    "Are you sure you want delete ?",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text("Yes")),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        child: const Text("No"),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );

                            if (result != null && result) {
                              _handleDelete(notes[index].id);
                            }
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute<Note>(
              builder: (BuildContext context) => const EditScreen(),
            ),
          );

          if (result != null) {
            if (result.id == "") {
              setState(() {
                sampleNotes.add(Note(
                    id: DateTime.now().toString(),
                    title: result.title,
                    content: result.content,
                    modifiedTime: result.modifiedTime));
              });
            }
          }
        },
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
