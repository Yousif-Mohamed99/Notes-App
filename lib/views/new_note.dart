import 'package:flutter/material.dart';
import 'package:notes_app/widgets/colors_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/provider/user_notes.dart';

class NewNote extends ConsumerStatefulWidget {
  const NewNote({super.key});

  @override
  ConsumerState<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends ConsumerState<NewNote> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle;
  var _enteredContent;
  Color _selectedColor = const Color(0xffe3d081);

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ref
          .read(userNotesProvider.notifier)
          .addNote(_enteredTitle, _enteredContent, _selectedColor);

      Navigator.of(context).pop();
    }
  }

  void _updatedColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height *
            0.5, // Limit to 50% of screen height
      ),

      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: 40,
            bottom:
                MediaQuery.of(context).viewInsets.bottom +
                40, // Adjusts padding for keyboard
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // Ensures the column takes minimum space
            children: [
              Form(
                key: _formKey, // Assign the form key here
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                          'Title',
                          style: TextStyle(
                            color: Color.fromARGB(255, 78, 144, 250),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 55, 71, 97),
                          ),
                        ),
                      ),
                      maxLength: 20,
                      cursorColor: Color.fromARGB(255, 78, 144, 250),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title is required';
                        }
                        if (value.trim().length < 2) {
                          return 'Title must be at least 2 characrers.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredTitle = value;
                      },
                    ),
                    SizedBox(height: 14),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: Text(
                          'Content',
                          style: TextStyle(
                            color: Color.fromARGB(255, 78, 144, 250),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 55, 71, 97),
                          ),
                        ),
                      ),
                      cursorColor: Color.fromARGB(255, 78, 144, 250),
                      maxLines: 3,
                      maxLength: 400,
                      onSaved: (value) {
                        _enteredContent = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Content is required';
                        }
                        if (value.trim().length < 5) {
                          return 'Content must be at least 5 characrers.';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 14),
                    ColorsListView(onColorSelected: _updatedColor),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50),
                  backgroundColor: Color.fromARGB(255, 78, 144, 250),
                ),
                child: Text(
                  'Add',
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
      ),
    );
  }
}
