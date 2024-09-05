import 'dart:convert';
import 'package:sqflite_crud/database/note_database.dart';
import 'package:sqflite_crud/note_model.dart';

class NoteDao{

  final NoteDatabase dbProvider;

  NoteDao([NoteDatabase? dbProvider]) : dbProvider = dbProvider ?? NoteDatabase.instance;


  Future<void> insertNote({required NoteModel note}) async{
      final db = await dbProvider.database;
      try{
        await db.rawInsert("INSERT INTO notes(title, desc) VALUES(?,?)", [note.title, note.desc]);
        var result = await db.rawQuery("SELECT * FROM notes");
        print(result);
      }catch(e){
        print(e);
      }
  }

  Future<List<NoteModel>> getNotes()async{
    final db = await dbProvider.database;
    List<NoteModel> list = [];
    var result;
    try{
      result = await db.rawQuery("SELECT * FROM notes");
      print(result);
    }catch(e){
      print(e);
    }
    for(var row in result){
      NoteModel note = NoteModel.fromMap(row);
      list.add(note);
    }
    Future<List<NoteModel>> futureList = Future.value(list);
    print(futureList);
    return futureList;
  }

  Future<void> deleteNote(NoteModel note) async{
    final db = await dbProvider.database;
    try{
      await db.delete("notes", where: 'id = ?', whereArgs: [note.id]);
    }catch(e){
      print(e);
    }
  }
  
  Future<void> updateNote(NoteModel note) async{
    final db = await dbProvider.database;
    try{
      await db.update("notes", note.toMap(), where: 'id = ?', whereArgs: [note.id] );
    }catch(e){
      print(e);
    }
  }

}