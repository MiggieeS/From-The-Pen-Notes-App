import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../BackEnd/note_operations.dart';
import '../BackEnd/note_data.dart';
import 'inner_notes_page.dart';
import 'home_page.dart';

class CreatePageWidget extends StatefulWidget {
  final String selectedFolder;

  const CreatePageWidget({super.key, required this.selectedFolder});

  @override
  State<CreatePageWidget> createState() => _CreatePageWidgetState();
}

class _CreatePageWidgetState extends State<CreatePageWidget> {
  late TextEditingController _taskTextController;
  late FocusNode _taskFocusNode;
  late TextEditingController _imageUrlController;
  late FocusNode _imageUrlFocusNode;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Color? _selectedColor; // State variable for selected color

  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    _taskTextController = TextEditingController();
    _taskFocusNode = FocusNode();
    _imageUrlController = TextEditingController();
    _imageUrlFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _taskTextController.dispose();
    _taskFocusNode.dispose();
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
        backgroundColor: const Color(0xFF1C1C1C),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1C1C1C),
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Note',
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Color(0xFFFFDEA7),
                    fontSize: 24,
                  ),
                ),
              ),
              Text(
                'Please fill out the form below to continue.',
                style: GoogleFonts.readexPro(
                  textStyle: const TextStyle(
                    color: Color(0xFF766851),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 12, 8),
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () async {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(selectedColor: _selectedColor)),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
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
                            constraints: const BoxConstraints(
                              maxWidth: 770,
                            ),
                            decoration: const BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 12, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: _taskTextController,
                                    focusNode: _taskFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    decoration: InputDecoration(
                                      labelText: 'Task or Title',
                                      labelStyle: GoogleFonts.readexPro(
                                        textStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      hintStyle: GoogleFonts.readexPro(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      errorStyle: GoogleFonts.readexPro(
                                        textStyle: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder:
                                      OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFF1C1C1C),
                                      contentPadding:
                                      const EdgeInsetsDirectional
                                          .fromSTEB(
                                          16, 20, 16, 20),
                                    ),
                                    style: GoogleFonts.readexPro(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
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
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: _imageUrlController,
                                    focusNode: _imageUrlFocusNode,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      labelText: 'Image URL (optional)',
                                      labelStyle: GoogleFonts.readexPro(),
                                      hintStyle: GoogleFonts.readexPro(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFF1C1C1C),
                                      contentPadding:
                                      const EdgeInsetsDirectional
                                          .fromSTEB(
                                          16, 16, 16, 16),
                                    ),
                                    style: GoogleFonts.readexPro(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    cursorColor: Colors.blue,
                                  ),
                                  const SizedBox(height: 12),
                                  // Color Picker Section
                                  Text(
                                    'Select a Color:',
                                    style: GoogleFonts.readexPro(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: _colors.map((color) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedColor = color;
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: color,
                                          radius: 30,
                                          child: _selectedColor == color
                                              ? const Icon(Icons.check,
                                              color: Colors.white)
                                              : null,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!
                                          .validate()) {
                                        // Create a new note and pass the color and image URL
                                        final newNote = NoteData(
                                          id: DateTime.now()
                                              .millisecondsSinceEpoch,
                                          text: _taskTextController.text,
                                          lastSaved: DateTime.now(),
                                          noteText: '',
                                          folder: widget.selectedFolder,
                                          color: _selectedColor,
                                          imageUrl:
                                          _imageUrlController.text,
                                        );
                                        noteOperations.addNewNote(newNote);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HomePage(
                                                    selectedColor:
                                                    _selectedColor),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Get Started',
                                      style: GoogleFonts.readexPro(
                                        textStyle: const TextStyle(
                                          color: Color(0xFF222222),
                                        ),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xFFFFDEA7),
                                      padding:
                                      const EdgeInsetsDirectional
                                          .fromSTEB(
                                          24, 0, 24, 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32),
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
