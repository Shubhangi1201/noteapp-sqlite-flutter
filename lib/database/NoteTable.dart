import 'package:sqflite/sqflite.dart';

class NoteTable{
  static const String NOTE_TABLE_NAME = "notes";
  static const String NOTE_ID = "id";
  static const String NOTE_TITLE = "title";
  static const String NOTE_DESC = "desc";

  static void createTable(Database db, int version)async{
    try{
        db.execute('''
          CREATE TABLE ${NOTE_TABLE_NAME}(
              $NOTE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
              $NOTE_TITLE TEXT,
              $NOTE_DESC TEXT
          )
          '''
        );

        print("database created.......................");
    }catch(e){
      print("failed to create database.......................");
    }
  }
}