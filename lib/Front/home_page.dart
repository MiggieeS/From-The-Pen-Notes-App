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
                  margin: EdgeInsets.only(top: 20.0),
                  child:SizedBox(
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
        body:Stack(
            children: [
              // Dropdown to select a folder when creating a new one!!
              DropdownButton<String>(
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
              Expanded(
                child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: noteOperations.getAllNotes().length,
                itemBuilder: (context, index) {
                  var note = noteOperations.getAllNotes()[index];
                  return GestureDetector(
                    onTap: () => _onNoteTap(context, note),
                    child: Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFF474747),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                              color: widget.selectedColor ?? const Color(0xFF474747),
                              image: widget.selectedColor == null
                                  ? DecorationImage(
                                image: NetworkImage(
                                    'https://images-ext-1.discordapp.net/external/gz02ColGW9ZW-3n-7N-VOp6skscaWuRtoMbpc7ultY8/https/pbs.twimg.com/media/GXIJhtUbEAELjo_.jpg%3Alarge?format=webp&width=901&height=676'),
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
              ), // First floating button
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
              // Second floating button
              Positioned(
                bottom: 115,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Create new Folder'),
                        content: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Folder name'
                          ),
                        ),
                        actions: [
                          TextButton( onPressed: () => Navigator.pop(context),
                              child: Text('cancel')
                          ),
                          TextButton( onPressed: () => Navigator.pop(context),
                              child: Text('ok')
                          ),
                        ],
                      )
                    );
                  },
                  backgroundColor: const Color(0xFFFFDEA7),
                  child: const Icon(Icons.folder_open, color: Color(0xFF1C1C1C)),
                ),
              ),
            ],
          ),
        )
      );
  }
}

