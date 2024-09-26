/*REFERENCE/S:
*
*
*
*
https://www.youtube.com/watch?v=BUCCHdKwKxE
* https://www.youtube.com/watch?v=Jd8Lom3I6Qc*/

import 'package:flutter/material.dart';

class NoteData{
  int id;
  String text;
  DateTime lastSaved; //added -gab
  String noteText;
  final String? imageUrl;
  final Color? color;



  NoteData({
    required this.id,
    required this.text,
    required this.lastSaved, //added -gab
    required this.noteText, //added -gab
    this.imageUrl,
    this.color,
  });
}