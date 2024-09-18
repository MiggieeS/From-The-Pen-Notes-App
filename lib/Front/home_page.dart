import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'CreatePage.dart';
import '../BackEnd/note_data.dart';
import '../BackEnd/note_operations.dart';
import 'inner_notes_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: const Color(0xFF1c1c1c),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1c1c1c),
          automaticallyImplyLeading: false, // remove back button
          title: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
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
                          // Handle profile button press
                          print('Profile button pressed');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Notes', icon: const Icon(Icons.note, color: Color(0xFFFFDEA7))),
              Tab(text: 'Folder', icon: const Icon(Icons.folder, color: Color(0xFFFFDEA7))),
            ],
            labelColor: const Color(0xFFFFDEA7),
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
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
                        // Image on top
                        Container(// edit bere bro
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                            image: DecorationImage(
                              image: NetworkImage('https://images-ext-1.discordapp.net/external/gz02ColGW9ZW-3n-7N-VOp6skscaWuRtoMbpc7ultY8/https/pbs.twimg.com/media/GXIJhtUbEAELjo_.jpg%3Alarge?format=webp&width=901&height=676'), // Replace with your image URL
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Text and actions inside a Row
                        Expanded(
                          child: Row(
                            children: [
                              // Note Title on the left
                              Expanded(
                                child: Center(
                                  child: Text(
                                    note.text, // Replace with dynamic content
                                    style: GoogleFonts.readexPro(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              // Actions on the right
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
                                      onPressed: () {
                                        // Handle star action
                                      },
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
          ],// edit here dean wzzap
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigate to the CreatePageWidget and wait for a result
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreatePageWidget(),
              ),
            );

            // If a new note was created, add it to the notes
            if (result != null && result is NoteData) {
              noteOperations.addNewNote(result);
            }
          },
          backgroundColor: const Color(0xFFFFDEA7),
          child: const Icon(Icons.add, color: Color(0xFF1C1C1C)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
