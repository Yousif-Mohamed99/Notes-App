import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/provider/user_notes.dart';
import 'package:notes_app/views/edit_note.dart';
import 'package:notes_app/widgets/note_item.dart';

class Notes extends ConsumerWidget {
  const Notes({super.key, required this.notes});

  final List<Note> notes;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deleteNote(int index) async {
      final bool? isDelete = await showDialog<bool>(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Delete Note'),
              content: Text('Are you sure you want to delete this note?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
      );
      // To delete a note
      if (isDelete == true) {
        ref.read(userNotesProvider.notifier).deleteNote(index);
      } else {
        return;
      }
    }

    void editNote(int index) async {
      final note = notes[index];
      await showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder:
            (ctx) => EditNote(
              index: index,
              initialTitle: note.title,
              initialContent: note.content,
              color: note.color, // Pass the current color
            ),
      );
    }

    final content = Center(child: Text('No Notes Added Yet'));

    if (notes.isEmpty) {
      return content;
    }

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder:
          (ctx, index) => GestureDetector(
            onTap: () => editNote(index), // Navigate to the edit screen on tap
            child: NoteItem(
              title: notes[index].title,
              content: notes[index].content,
              onDelete: () => deleteNote(index),
              color: notes[index].color,
            ),
          ),
    );
  }
}
