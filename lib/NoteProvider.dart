

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_crud/note_model.dart';

class NoteProvider extends ChangeNotifier{

  List<NoteModel> _noteList = [];

  List<NoteModel> get noteList => _noteList;

  void updateNoteList(List<NoteModel> noteList){
    _noteList.clear();
    _noteList = noteList;
    notifyListeners();
  }

}