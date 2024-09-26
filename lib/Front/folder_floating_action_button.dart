import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FolderButton extends StatefulWidget{
  const FolderButton({super.key});
  @override
  State<FolderButton> createState() => _FolderFloatingActionButton();
}
class _FolderFloatingActionButton extends State<FolderButton>{
  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
        onPressed: (){}
      );
  }
}
