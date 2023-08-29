import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/models.dart';

class NoteEditPage extends StatefulWidget {
  final Note? note;

  NoteEditPage({Key? key, this.note}) : super(key: key);

  @override
  _NoteEditPageState createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? '');
    descriptionController =
        TextEditingController(text: widget.note?.description ?? '');
    categoryController = TextEditingController(text: widget.note?.category ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Note')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            ElevatedButton(
              onPressed: () {
                final noteBox = Hive.box<Note>('notes');
                if (widget.note != null) {
                  widget.note!.title = titleController.text;
                  widget.note!.description = descriptionController.text;
                  widget.note!.category = categoryController.text;
                  noteBox.put(widget.note!.hiveKey!, widget.note!); // Update existing note
                } else {
                  final newNote = Note(
                    title: titleController.text,
                    description: descriptionController.text,
                    category: categoryController.text,
                  );
                  noteBox.add(newNote); // Create new note
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
