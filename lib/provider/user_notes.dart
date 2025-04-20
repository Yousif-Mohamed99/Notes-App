import 'package:notes_app/model/note.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  String path = join(dbPath, 'notes.db');

  final db = sql.openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE user_notes(title TEXT, content TEXT, color INTEGER)',
      );
    },
  );

  return db;
}

class UserNotesNotifier extends StateNotifier<List<Note>> {
  UserNotesNotifier() : super(const []);

  void addNote(String title, String content, Color color) async {
    final newNote = Note(title: title, content: content, color: color);

    final db = await getDatabase();

    await db.insert('user_notes', {
      'title': title,
      'content': content,
      'color': color.toARGB32(),
    });

    state = [newNote, ...state];
  }

  void deleteNote(int index) async {
    if (index < 0 || index >= state.length) return;

    final db = await getDatabase();
    final noteToDelete = state[index];

    await db.delete(
      'user_notes',
      where: 'title = ? AND content = ? AND color = ?',
      whereArgs: [
        noteToDelete.title,
        noteToDelete.content,
        noteToDelete.color.toARGB32(),
      ],
    );

    state = List<Note>.from(state)..removeAt(index);
  }

  void editNote(int index, String newTitle, String newContent) async {
    if (index < 0 || index >= state.length) return;

    final db = await getDatabase();
    final noteToEdit = state[index];

    await db.update(
      'user_notes',
      {'title': newTitle, 'content': newContent},
      where: 'title = ? AND content = ? AND color = ?',
      whereArgs: [
        noteToEdit.title,
        noteToEdit.content,
        noteToEdit.color.toARGB32(),
      ],
    );

    state = List<Note>.from(state)
      ..[index] = Note(
        title: newTitle,
        content: newContent,
        color: noteToEdit.color, // Keep the existing color
      );
  }

  Future<void> loadInputs() async {
    final db = await getDatabase();

    final data = await db.query('user_notes');

    final notes =
        data
            .map(
              (row) => Note(
                title: row['title'] as String,
                content: row['content'] as String,
                color: Color(row['color'] as int),
              ),
            )
            .toList();

    state = notes;
  }
}

final userNotesProvider = StateNotifierProvider<UserNotesNotifier, List<Note>>((
  ref,
) {
  return UserNotesNotifier();
});
