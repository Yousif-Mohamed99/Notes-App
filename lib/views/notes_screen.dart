import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/provider/user_notes.dart';
import 'package:notes_app/views/new_note.dart';
import 'package:notes_app/widgets/custom_app_bar.dart';
import 'package:notes_app/widgets/notes.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  late Future<void> _notesFuture;
  @override
  void initState() {
    super.initState();
    _notesFuture = ref.read(userNotesProvider.notifier).loadInputs();
  }

  void addNote() async {
    final newNote = await showModalBottomSheet<Note>(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewNote(),
    );
    if (newNote == null) {
      return;
    }
  }

  @override
  Widget build(context) {
    final notesList = ref.watch(userNotesProvider);
    return Scaffold(
      appBar: CustomAppBar(title: 'Notes App', icon: Icons.search),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: FutureBuilder(
        future: _notesFuture,
        builder:
            (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : Notes(notes: notesList),
      ),
    );
  }
}
