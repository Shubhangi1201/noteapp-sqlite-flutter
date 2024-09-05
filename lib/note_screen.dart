import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_crud/NoteProvider.dart';
import 'package:sqflite_crud/database/note_dao.dart';
import 'package:sqflite_crud/note_model.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController noteController = TextEditingController();
  TextEditingController descController = TextEditingController();
  NoteDao noteDao = NoteDao();

  @override
  void initState() {
    getDbData();
  }

  void getDbData() async {
    List<NoteModel> notes = await noteDao.getNotes();
    Provider.of<NoteProvider>(context, listen: false).updateNoteList(notes);
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      // body: ListView(
      //   children: [
      //       ListTile(
      //         title: Text("title"),
      //         subtitle: Text("descritpion"),
      //         trailing: Icon(Icons.delete),
      //       )
      //   ],
      // ),

      body: ListView.builder(
          itemCount: Provider.of<NoteProvider>(context, listen: true).noteList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(Provider.of<NoteProvider>(context, listen: true).noteList[index].title),
              subtitle: Text(Provider.of<NoteProvider>(context, listen: true).noteList[index].desc),
              trailing: Icon(Icons.delete),
            );
          }
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => AlertDialogWidget());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void insertNote(String title, String desc) async {
    NoteModel note = NoteModel(title: title, desc: desc);
    try {
      await noteDao.insertNote(note: note);
      getDbData();
    } catch (e) {
      print('error in note_screen.dart');
    }
    Navigator.pop(context);
  }

  Widget AlertDialogWidget() {
    return AlertDialog(
      title: Text("Add Note"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: noteController,
            decoration: InputDecoration(
                labelText: "Title",
                hintText: "Enter title",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 12,
          ),
          TextField(
            controller: descController,
            decoration: InputDecoration(
                labelText: "Description",
                hintText: "Enter description",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 12,
          ),
          ElevatedButton(
              onPressed: () {
                insertNote(noteController.text, descController.text);
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
