import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BackEnd/note_operations.dart';
import 'Front/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteOperations>(
          create: (_) => NoteOperations(),
        ),
      ],
      child: MaterialApp(

        title: 'Note Taking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}
