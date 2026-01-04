import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:studdy_buddy/components/custom_app_bar.dart';
import 'package:studdy_buddy/components/page_background.dart';
import 'package:studdy_buddy/models/note_model.dart';
import 'package:studdy_buddy/pages/create_note_page.dart';
import 'package:studdy_buddy/pages/notes_detail_page.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:studdy_buddy/utils/themes/app_dark_theme.dart';

class NotesPage extends StatelessWidget {
  final String topicId;
  const NotesPage({super.key, required this.topicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          iconColor: primaryContainerColor(context),
          backgroundColor: elevationColor(context),
          padding: EdgeInsets.all(12),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNotePage(topicId: topicId),
            ),
          );
        },
        child: Icon(Icons.add, size: 40),
      ),
      appBar: CustomAppBar(
        title: Text(
          'Notes',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge!.apply(color: Colors.white),
        ),
        showActionIcon: false,
      ),
      backgroundColor: secondaryColor(context),
      body: Background(
        body: FutureBuilder(
          future: context.read<StudyBuddyServices>().fetchNotes(topicId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isEmpty
                  ? Center(
                      child: Text(
                        'No notes has been added yet..',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    )
                  : StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Note note = snapshot.data![index];
                        Color color = notesColor(context)[2];
                        if (index % 4 == 0) {
                          color = notesColor(context)[1];
                        } else if (index % 3 == 0) {
                          color = notesColor(context)[0];
                        } else if (index % 2 == 0) {
                          color = notesColor(context)[3];
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkResponse(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotesDetailPage(
                                    color: color == Colors.white
                                        ? secondaryColor(context)
                                        : color,
                                    note: note,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge,
                                  ),
                                  Text(
                                    note.content.length >= 20
                                        ? '${note.content.substring(0, 20)}...'
                                        : note.content,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) =>
                          StaggeredTile.count(2, index.isEven ? 2 : 4),
                    );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
