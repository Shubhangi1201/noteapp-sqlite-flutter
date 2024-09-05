import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_crud/database/NoteTable.dart';

class NoteDatabase{
  static final NoteDatabase instance = NoteDatabase();
  static const DATABASE_NAME = "notes.db";
  static const DATABASE_VERSION = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      print("database is not null");
      return _database!;
    }

    _database = await _initDatabase();
    print("database is null");
    return _database!;
  }

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE_NAME);
    var database;

    // final path = '$databasePath/notes.db';
    try{
        database =  await openDatabase(path, version: NoteDatabase.DATABASE_VERSION, onCreate: _createDatabase);
    }catch(e){
      print(e);
    }

    return database;
  }

  void _createDatabase(Database database, int version)async{
     NoteTable.createTable(database, version);
  }

}