import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app_v2/Front/profilePage.dart';
import 'package:provider/provider.dart';
import 'CreatePage.dart';
import '../BackEnd/note_data.dart';
import '../BackEnd/note_operations.dart';
import 'inner_notes_page.dart';

class HomePage extends StatefulWidget {
  final Color? selectedColor;

  const HomePage({Key? key, this.selectedColor}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedFolder = 'default';

  void _onNoteTap(BuildContext context, NoteData note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InnerNotesPage(noteData: note),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var noteOperations = Provider.of<NoteOperations>(context);
    List<NoteData> filteredNotes = noteOperations.getNotesByFolder(selectedFolder);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF1c1c1c),
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: const Color(0xFF1c1c1c),
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    child: TextField(
                      style: GoogleFonts.readexPro(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: GoogleFonts.readexPro(
                          color: const Color(0xFF878787),
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF474747),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFFFFDEA7)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.person, color: Color(0xFFFFDEA7)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: filteredNotes.length,
                  itemBuilder: (context, index) {
                    var note = filteredNotes[index];
                    return GestureDetector(
                      onTap: () => _onNoteTap(context, note),
                      child: Container(
                        height: 200,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFF474747), // Apply the selected color here
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                color: note.color ?? const Color(0xFF474747), // Default to note's selected color
                                image: note.imageUrl != null && note.imageUrl!.isNotEmpty // Check if image URL exists
                                    ? DecorationImage(
                                  image: NetworkImage(note.imageUrl!),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        note.text,
                                        style: GoogleFonts.readexPro(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Color(0xFFFFDEA7)),
                                          onPressed: () {
                                            noteOperations.deleteNode(note);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.star_border, color: Color(0xFFFFDEA7)),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Floating Action Button for adding new notes
            Positioned(
              bottom: 50,
              right: 20,
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePageWidget(selectedFolder: selectedFolder), // Pass the selected folder here
                    ),
                  );
                  if (result != null && result is NoteData) {
                    noteOperations.addNewNote(result);
                  }
                },
                backgroundColor: const Color(0xFFFFDEA7),
                child: const Icon(Icons.add, color: Color(0xFF1C1C1C)),
              ),
            ),
            // Floating Action Button for creating new folders
            Positioned(
              bottom: 120,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      String folderName = ''; // Track folder name input
                      return AlertDialog(
                        title: const Text('Create new Folder'),
                        content: TextField(
                          onChanged: (value) {
                            folderName = value; // Capture the folder name
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Folder name',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (folderName.isNotEmpty) {
                                noteOperations.createFolder(folderName);
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                },
                backgroundColor: const Color(0xFFFFDEA7),
                child: const Icon(Icons.folder_open, color: Color(0xFF1C1C1C)),
              ),
            ),
            // Dropdown to select a folder
            Positioned(
              right: 210,
              child: DropdownButton<String>(
                value: selectedFolder,
                items: noteOperations.getAllFolders().map((folder) {
                  return DropdownMenuItem<String>(
                    value: folder,
                    child: Text(folder, style: GoogleFonts.readexPro(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFolder = value!;
                  });
                },
                dropdownColor: const Color(0xFF474747),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
