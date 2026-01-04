import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/custom_app_bar.dart';
import 'package:studdy_buddy/components/page_background.dart';
import 'package:studdy_buddy/models/note_model.dart';
import 'package:studdy_buddy/pages/notes_page.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class NotesDetailPage extends StatelessWidget {
  final Color color;
  final Note note;
  const NotesDetailPage({super.key, required this.color, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Column(
        children: [
          Container(
            color: color,
            width: double.infinity,
            height: 220,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NotesPage(topicId: note.topicId),
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_back, size: 30),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit, size: 30),
                        ),

                        IconButton(
                          onPressed: () async {
                            await context.read<StudyBuddyServices>().removeNote(
                              note.id,
                            );
                            // Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NotesPage(topicId: note.topicId),
                              ),
                            );
                          },
                          icon: Icon(Icons.delete, size: 30),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      note.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat(
                        DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                      ).format(note.createdAt),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Background(
              height: MediaQuery.sizeOf(context).height - 255,
              body: Text(
                note.content,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
