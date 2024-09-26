import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app_v2/Front/profilePage.dart';
import 'package:provider/provider.dart';
import 'CreatePage.dart';
import '../BackEnd/note_data.dart';
import '../BackEnd/note_operations.dart';
import 'inner_notes_page.dart';

class HomePage extends StatelessWidget {
  final Color? selectedColor;

  const HomePage({Key? key, this.selectedColor}) : super(key: key);

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
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF1c1c1c),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1c1c1c),
          automaticallyImplyLeading: false,
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
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Notes', icon: const Icon(Icons.note, color: Color(0xFFFFDEA7))),
              Tab(text: 'Folders', icon: const Icon(Icons.folder, color: Color(0xFFFFDEA7))),
            ],
            labelColor: const Color(0xFFFFDEA7),
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
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
                          color: note.color ?? const Color(0xFF474747), // Use note's color
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                color: note.color ?? const Color(0xFF474747), // Use note's color
                                image: note.imageUrl != null
                                    ? DecorationImage(
                                  image: NetworkImage(note.imageUrl!), // Use note's image URL
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
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15.0, left: 7.0, right: 7.0),
                      child: const FolderButton(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: noteOperations.getAllNotes().length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            // First floating button
            Positioned(
              bottom: 80,
              right: 20,
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePageWidget(),
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
              bottom: 150,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  // Action for the second button
                  print('Second FAB pressed');
                },
                backgroundColor: const Color(0xFFFFDEA7),
                child: const Icon(Icons.folder_open, color: Color(0xFF1C1C1C)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FolderButton extends StatefulWidget {
  const FolderButton({Key? key}) : super(key: key);

  @override
  State<FolderButton> createState() => _FolderButtonState();
}

class _FolderButtonState extends State<FolderButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 500,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFDEA7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Create new Folder'),
              actions: [
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Folder name',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ok'),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        child: Text(
          "Create Folder",
          style: GoogleFonts.readexPro(
            color: const Color(0xFF474747),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
