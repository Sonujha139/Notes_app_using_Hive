import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import the fluttertoast package
import '../model/models.dart';
import 'noteseditpage.dart';

class NoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesBox = Hive.box<Note>('notes');

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        backgroundColor: Colors.purple.shade100,
      ),
      body: ValueListenableBuilder(
        valueListenable: notesBox.listenable(),
        builder: (context, Box<Note> box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text('No Data Found'),
            );
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final note = box.getAt(index)!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slidable(
                  actionPane: const SlidableDrawerActionPane(),
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.category),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteEditPage(note: note),
                        ),
                      );
                    },
                    tileColor: Colors.grey.shade400,
                    contentPadding: EdgeInsets.all(6.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  actions: [
                    IconSlideAction(
                      caption: 'Undo',
                      color: Colors.green,
                      icon: Icons.undo,
                      onTap: () {
                        // Handle undo action
                        // You can add your logic to undo the action here
                      },
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        // Handle delete action
                        // You can add your logic to permanently delete here
                        notesBox.deleteAt(index);

                        // Show a toast message
                        Fluttertoast.showToast(
                          msg: "Note Deleted!",
                          backgroundColor: Colors.red,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
