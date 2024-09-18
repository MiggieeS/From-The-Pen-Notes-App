import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../BackEnd/note_operations.dart';
import '../BackEnd/note_data.dart';
import 'home_page.dart'; // Import the HomePage

class InnerNotesPage extends StatefulWidget {
  final NoteData noteData;

  const InnerNotesPage({Key? key, required this.noteData}) : super(key: key);

  @override
  _InnerNotesPageState createState() => _InnerNotesPageState();
}

class _InnerNotesPageState extends State<InnerNotesPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.noteData.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var noteOperations = Provider.of<NoteOperations>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(// edit here
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
        ),
      ),
      body: Padding( //edit here
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          expands: true,
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
            noteOperations.updateNote(widget.noteData, value);
          },
        ),
      ),
    );
  }
}
