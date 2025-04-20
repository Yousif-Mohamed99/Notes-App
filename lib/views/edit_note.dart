import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/provider/user_notes.dart';

class EditNote extends ConsumerStatefulWidget {
  const EditNote({
    super.key,
    required this.index,
    required this.initialTitle,
    required this.initialContent,
    required this.color,
  });

  final int index;
  final String initialTitle;
  final String initialContent;
  final Color color;

  @override
  ConsumerState<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends ConsumerState<EditNote> {
  final _formKey = GlobalKey<FormState>();
  late String _updatedTitle;
  late String _updatedContent;

  @override
  void initState() {
    super.initState();
    _updatedTitle = widget.initialTitle;
    _updatedContent = widget.initialContent;
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ref
          .read(userNotesProvider.notifier)
          .editNote(widget.index, _updatedTitle, _updatedContent);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 40,
          bottom: MediaQuery.of(context).viewInsets.bottom + 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.initialTitle,
                    decoration: InputDecoration(
                      label: Text('Title'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      if (value.trim().length < 2) {
                        return 'Title must be at least 2 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _updatedTitle = value!;
                    },
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    initialValue: widget.initialContent,
                    decoration: InputDecoration(
                      label: Text('Content'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLines: 3,
                    maxLength: 400,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Content is required';
                      }
                      if (value.trim().length < 5) {
                        return 'Content must be at least 5 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _updatedContent = value!;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 50),
                backgroundColor: widget.color,
              ),
              child: Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
