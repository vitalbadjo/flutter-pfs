import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NoteItemModel {
  NoteItemModel(this.title, this.description);
  String title;
  String description;
}

class NotesController {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  getNotes(String uid) async {
    final notes = await _database.ref('users/$uid/notes').get();
    if (notes.exists) {
      print(notes.value);
    } else {
      print('No data available.');
    }
    return notes;
  }

  addNote(context, String uid, Map note) async {
    final newNoteKey =
        FirebaseDatabase.instance.ref('users/$uid').child('posts').push().key;

    final Map<String, Map> updates = {};
    updates['/users/$uid/notes/$newNoteKey'] = note;

    return FirebaseDatabase.instance
        .ref()
        .update(updates)
        .then((_) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Updated!!!'),
                  action: SnackBarAction(
                    label: 'Action',
                    onPressed: () {
                      // Code to execute.
                    },
                  ),
                ),
              )
            })
        .catchError((_) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Something went wrong :('),
                  action: SnackBarAction(
                    label: 'Action',
                    onPressed: () {
                      // Code to execute.
                    },
                  ),
                ),
              )
            });
  }
}
