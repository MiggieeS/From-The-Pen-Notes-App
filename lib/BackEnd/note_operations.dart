/*REFERENCE/S:
*
* These are backend processes from this video:
* https://www.youtube.com/watch?v=BUCCHdKwKxE
*
* (as it stands, we might have to change this entirely, or might add something.)
*  This code does not allow local save, there are no firebase/hive databases being used
*/


import 'package:flutter/cupertino.dart';

import 'note_data.dart';

class NoteOperations extends ChangeNotifier{
  List<NoteData> allNotes = [
    NoteData(id:0, text: 'Test Note (1)', lastSaved:DateTime.now(), noteText: '')
    // added lastSaved:DateTime.now(), noteText: '' -gab
  ];

  List<NoteData> getAllNotes (){
    return allNotes;
  }
  void addNewNote(NoteData noteData){
    allNotes.add(noteData);
    notifyListeners();
  }

  void updateNote(NoteData noteData, String text){
    for (int i = 0; i<allNotes.length;i++){
      if(allNotes[i].id == noteData.id){
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  void deleteNode(NoteData noteData){
    allNotes.remove(noteData);
    notifyListeners();

  }
}