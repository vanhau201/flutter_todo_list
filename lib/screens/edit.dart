import 'package:flutter/material.dart';
import 'package:todo_list/models/note.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleControler = TextEditingController();
  TextEditingController _contentControler = TextEditingController();

  @override
  void initState() {
    // init state
    super.initState();
    if (widget.note != null) {
      _titleControler = TextEditingController(text: widget.note!.title);
      _contentControler = TextEditingController(text: widget.note!.content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 40, right: 16),
        child: Column(children: [
          Row(
            children: [
              IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(0.8),
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
                maxLines: null,
                controller: _titleControler,
                style: const TextStyle(fontSize: 30, color: Colors.grey),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
              ),
              TextField(
                maxLines: null,
                controller: _contentControler,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type some here",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
              )
            ],
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
              context,
              Note(
                  id: widget.note != null ? widget.note!.id : "",
                  title: _titleControler.text,
                  content: _contentControler.text,
                  modifiedTime: DateTime.now()));
        },
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.save,
        ),
      ),
    );
  }
}
