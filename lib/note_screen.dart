import 'dart:ffi';

import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController noteController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: ListView(
        children: [
            ListTile(
              title: Text("title"),
              subtitle: Text("descritpion"),
              trailing: Icon(Icons.delete),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            showDialog(context: context, builder: (context)=> AlertDialogWidget());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

Widget AlertDialogWidget(){
  return AlertDialog(
    title: Text("Add Note"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: noteController ,
          decoration: InputDecoration(
            labelText: "Title",
            hintText: "Enter title",
            border: OutlineInputBorder()
          ),
        ),
        SizedBox(height: 12,),
        TextField(
          controller: noteController ,
          decoration: InputDecoration(
              labelText: "Description",
              hintText: "Enter description",
              border: OutlineInputBorder()
          ),
        ),
        SizedBox(height: 12,),
        ElevatedButton(onPressed: (){}, child: Text("Submit"))
      ],
    ),
  );
}
}

