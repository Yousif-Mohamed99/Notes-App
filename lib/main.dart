import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/views/notes_screen.dart';

void main() {
  runApp(ProviderScope(child: NotesApp()));
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Roboto'),
      home: const NotesScreen(),
    );
  }
}
