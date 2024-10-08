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

class NoteOperations extends ChangeNotifier {
  List<NoteData> allNotes = [
    NoteData(id: 0, text: 'Test Note (1)', lastSaved: DateTime.now(), noteText: '', folder: 'default'),
    // Added folder property - default folder for the added existing notes such as test
  ];

  List<String> allFolders = ['default']; //Default folder

  List<NoteData> getAllNotes() {
    return allNotes;
  }

  // Get all notes in a specific folder
  List<NoteData> getNotesByFolder(String folder) {
    return allNotes.where((note) => note.folder == folder).toList();
  }

  void addNewNote(NoteData noteData) {
    allNotes.add(noteData);
    notifyListeners();
  }

  void updateNote(NoteData noteData, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == noteData.id) {
        allNotes[i].text = text;
        allNotes[i].lastSaved = DateTime.now(); // Update lastSaved timestamp
      }
    }
    notifyListeners();
  }

  void deleteNode(NoteData noteData) {
    allNotes.remove(noteData);
    notifyListeners();
  }

  // Create a new folder
  void createFolder(String folderName) {
    if (!allFolders.contains(folderName)) {
      allFolders.add(folderName);
      notifyListeners();
    }
  }

  // Get all folder names
  List<String> getAllFolders() {
    return allFolders;
  }
}

