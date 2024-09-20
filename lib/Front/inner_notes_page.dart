import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../BackEnd/note_operations.dart';
import '../BackEnd/note_data.dart';
import 'home_page.dart'; // Import the HomePage

class InnerNotesPage extends StatefulWidget {
  final NoteData noteData; //

  const InnerNotesPage({Key? key, required this.noteData}) : super(key: key); //

  @override
  _InnerNotesPageState createState() => _InnerNotesPageState();
}

class _InnerNotesPageState extends State<InnerNotesPage> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  String _initialTitle = '';
  //before: late TextEditingController _controller; -gab

  @override
  void initState() {
    super.initState();
    _initialTitle = widget.noteData.text;
    _titleController = TextEditingController(text: _initialTitle);
    _noteController = TextEditingController(text: widget.noteData.noteText);
    // before: _controller = TextEditingController(text: widget.noteData.text); - gab
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    //before: _controller.dispose(); - gab
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var noteOperations = Provider.of<NoteOperations>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          shadowColor: Colors.black.withOpacity(0.3),
          backgroundColor: const Color(0xFFFFDEA7),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Navigate to HomePage
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
          title: Text( //added title -gab
            _initialTitle,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.undo, color: Colors.black),
              onPressed: () {
                // Undo button functionality - gab
              },
            ),
            IconButton(
              icon: Icon(Icons.redo, color: Colors.black),
              onPressed: () {
                // Redo button functionality - gab
              },
            ),
            IconButton(
              icon: Icon(Icons.save, color: Colors.black),
              onPressed: () {
                // Save button functionality - gab
                noteOperations.updateNote(widget.noteData, _noteController.text);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( //added column instead of textfield - gab
          children: [
            Text(
              'Last Saved: ${widget.noteData.lastSaved}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _noteController,
                expands: true,
                minLines: null,
                maxLines: null,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.5,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter note text',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                onChanged: (value) {
                  widget.noteData.noteText = value;
                  //before: noteOperations.updateNote(widget.noteData, value); -gab
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}