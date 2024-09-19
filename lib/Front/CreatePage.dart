import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../BackEnd/note_operations.dart';
import '../BackEnd/note_data.dart';
import 'inner_notes_page.dart';
import 'home_page.dart';  // Import the HomePage

class CreatePageWidget extends StatefulWidget {
  const CreatePageWidget({super.key});

  @override
  State<CreatePageWidget> createState() => _CreatePageWidgetState();
}

class _CreatePageWidgetState extends State<CreatePageWidget> {
  late TextEditingController _taskTextController;
  late FocusNode _taskFocusNode;

  //removed description -gab

  late TextEditingController _imageUrlController;
  late FocusNode _imageUrlFocusNode;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _taskTextController = TextEditingController();
    _taskFocusNode = FocusNode();

    //removed description -gab

    _imageUrlController = TextEditingController();
    _imageUrlFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _taskTextController.dispose();
    _taskFocusNode.dispose();
    //removed description -gab
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var noteOperations = Provider.of<NoteOperations>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF1C1C1C),
        appBar: AppBar(
          backgroundColor: Color(0xFF1C1C1C),
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Note',
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    color: Color(0xFFFFDEA7),
                    letterSpacing: 0.0,
                    fontSize: 24,
                  ),
                ),
              ),
              Text(
                'Please fill out the form below to continue.',
                style: GoogleFonts.readexPro(
                  textStyle: TextStyle(
                    color: Color(0xFF766851),
                    letterSpacing: 0.0,
                    fontSize: 16,
                  ),
                ),
              ),
            ].map((widget) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: widget,
            )).toList(),
          ),
          actions: [
        Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 12, 8),
        child: IconButton(
        icon: Icon(
        Icons.close_rounded,
        color: Colors.white,
        size: 24,
        ),
        onPressed: () async {
          // Navigate to HomePage
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false,
          );
        },
      ),
    ),
    ],
    centerTitle: false,
    elevation: 0,
    ),
    body: SafeArea(
    top: true,
    child: Form(
    key: _formKey,
    autovalidateMode: AutovalidateMode.disabled,
    child: Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Expanded(
    child: SingleChildScrollView(
    child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
    Align(
    alignment: AlignmentDirectional(0, -1),
    child: Container(
    constraints: BoxConstraints(
    maxWidth: 770,
    ),
    decoration: BoxDecoration(),
    child: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
    child: Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    TextFormField(
    controller: _taskTextController,
    focusNode: _taskFocusNode,
    autofocus: true,
    textCapitalization: TextCapitalization.words,
    obscureText: false,
    decoration: InputDecoration(
    labelText: 'Task or Title',
    labelStyle: GoogleFonts.readexPro(
    textStyle: TextStyle(
    color: Colors.grey,
    letterSpacing: 0.0,
    ),
    ),
    hintStyle: GoogleFonts.readexPro(
    textStyle: TextStyle(
    letterSpacing: 0.0,
    color: Colors.white,
    ),
    ),
    errorStyle: GoogleFonts.readexPro(
    textStyle: TextStyle(
    color: Colors.red,
    fontSize: 12,
    letterSpacing: 0.0,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Colors.grey,
    width: 2,
    ),
    borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Colors.blue,
    width: 2,
    ),
    borderRadius: BorderRadius.circular(12),
    ),
    errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Colors.red,
    width: 2,
    ),
    borderRadius: BorderRadius.circular(12),
    ),
    focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Colors.red,
    width: 2,
    ),
    borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: Color(0xFF1C1C1C),
    contentPadding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
    ),
    style: GoogleFonts.readexPro(
    textStyle: TextStyle(
    color: Colors.white, // Ensure text color is white
    letterSpacing: 0.0,
    ),
    ),
    cursorColor: Colors.blue,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a task or title';
    }
    return null;
    },
    ),
    SizedBox(height: 12),
    TextFormField(
    controller: _imageUrlController,
    focusNode: _imageUrlFocusNode,
    autofocus: false,
    textCapitalization: TextCapitalization.none,
    obscureText: false,
    decoration: InputDecoration(
    labelText: 'Image URL (optional)',
    labelStyle: GoogleFonts.readexPro(
    textStyle: TextStyle(
    letterSpacing: 0.0,
    ),
    ),
    hintStyle: GoogleFonts.readexPro(
    textStyle: TextStyle(
    letterSpacing: 0.0,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Colors.grey,
    width: 2,
    ),
    borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Colors.blue,
    width: 2,
    ),
    borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: Color(0xFF1C1C1C),
    contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
    ),
    style: GoogleFonts.readexPro(
    textStyle: TextStyle(
    color: Colors.white, // Ensure text color is white
    letterSpacing: 0.0,
    ),
    ),
    cursorColor: Colors.blue,
    ),
    SizedBox(height: 12),
    ElevatedButton(
    onPressed: () {
    // Create a new note and navigate to InnerNotesPage
    final newNote = NoteData(
    id: DateTime.now().millisecondsSinceEpoch, // Unique ID for the note
    text: _taskTextController.text,
    lastSaved: DateTime.now(), noteText: '', // Add the date when it was last saved
    );
    // Add the new notes to the note operations
    noteOperations.addNewNote(newNote);
    // Navigate to InnerNotesPage
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => InnerNotesPage(noteData: newNote),
    ),
    );
    },
    child: Text(
    'Get Started',
    style: GoogleFonts.readexPro(
    textStyle: TextStyle(
    color: Color(0xFF222222),
    letterSpacing: 0.0,
    ),
    ),
    ),
    style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFFFDEA7),
    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    ),
    ),
    ),
    SizedBox(height: 32),
    ],
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    );
    }
}