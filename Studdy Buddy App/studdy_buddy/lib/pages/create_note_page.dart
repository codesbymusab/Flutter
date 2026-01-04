import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/custom_app_bar.dart';
import 'package:studdy_buddy/components/elevated_button.dart';
import 'package:studdy_buddy/components/form_text_field.dart';
import 'package:studdy_buddy/components/page_background.dart';
import 'package:studdy_buddy/models/note_model.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:uuid/uuid.dart';

class CreateNotePage extends StatefulWidget {
  final String topicId;
  const CreateNotePage({super.key, required this.topicId});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor(context),
      appBar: CustomAppBar(
        title: Text(
          'Add Note',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge!.apply(color: Colors.white),
        ),
        showActionIcon: false,
      ),
      body: Background(
        body: Column(
          spacing: 20,
          children: [
            SizedBox(
              height: 60,
              child: NoteField(
                controller: _titleController,
                hintText: 'Title',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.apply(color: Colors.black87),
              ),
            ),
            SizedBox(
              height: 300,
              child: NoteField(
                controller: _contentController,
                hintText: 'Note...',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.apply(color: Colors.black87),
              ),
            ),
            SizedBox(
              width: 200,
              height: 60,
              child: Expanded(
                child: AppElevatedButton(
                  onPressed: () async {
                    if (_titleController.text.isNotEmpty &&
                        _contentController.text.isNotEmpty) {
                      Note newNote = Note(
                        id: Uuid().v1(),
                        topicId: widget.topicId,
                        title: _titleController.text,
                        content: _contentController.text,
                        createdAt: DateTime.now(),
                      );

                      await context.read<StudyBuddyServices>().addNote(newNote);
                      setState(() {
                        _titleController.clear();
                        _contentController.clear();
                      });
                    }
                  },
                  label: 'Save',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle style;
  final String hintText;
  const NoteField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.left,
      maxLines: null,
      expands: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: secondaryColor(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: secondaryColor(context),
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
      ),
      cursorColor: primaryColor(context),
    );
  }
}
