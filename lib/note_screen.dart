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


  void getDbData() async {
    List<NoteModel> notes = await noteDao.getNotes();
    print(notes);
    Provider.of<NoteProvider>(context, listen: false).updateNoteList(notes);
  }


  void deleteNote(NoteModel note) async {
    await noteDao.deleteNote(note);
    getDbData();
  }

  void updateNote(String title, String desc, int id)async{
   //
   //  NoteModel note = NoteModel(id: id, title: title, desc: desc);
   // try{
   //   await noteDao.updateNote(note);
   //   getDbData();
   // }catch(e){
   //   print(e);
   // }
   //
   // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: ListView.builder(
          itemCount:
              Provider.of<NoteProvider>(context, listen: true).noteList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(Provider.of<NoteProvider>(context, listen: true)
                  .noteList[index]
                  .title),
              subtitle: Text(Provider.of<NoteProvider>(context, listen: true)
                  .noteList[index]
                  .desc),

              trailing: Column(
                children: [
                  InkWell(
                      onTap: () {
                        NoteModel note =
                            Provider.of<NoteProvider>(context, listen: false)
                                .noteList[index];
                        deleteNote(note);
                      },
                      child: Icon(Icons.delete)),
                  SizedBox(height: 8,),
                  InkWell(
                    onTap: (){
                      var id = Provider.of<NoteProvider>(context, listen: true).noteList[index].id;
                      print(id);
                      // Provider.of<NoteProvider>(context, listen: false).setCurrentNoteId(id!);
                      // showDialog(context: context, builder: (context)=>AlertDialogWidget("update"));
                    },
                    child: Icon(Icons.edit),
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => AlertDialogWidget("add"));
        },
        child: const Icon(Icons.add),
      ),
    );
  }



  Widget AlertDialogWidget(String eventType) {
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
                if(eventType == "update"){
                  int id = Provider.of<NoteProvider>(context, listen: false).currentNoteId;
                  updateNote(noteController.text, descController.text, id);
                }else{
                insertNote(noteController.text, descController.text);
                }
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
