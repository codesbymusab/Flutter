import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/learning_mode_tile.dart';
import 'package:studdy_buddy/components/topic_tile.dart';
import 'package:studdy_buddy/models/subject_model.dart';
import 'package:studdy_buddy/models/topic_model.dart';
import 'package:studdy_buddy/pages/flashcard_page.dart';
import 'package:studdy_buddy/pages/notes_page.dart';
import 'package:studdy_buddy/pages/quiz_question_page.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class LearningModePage extends StatelessWidget {
  final Topic topic;
  const LearningModePage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: mainGradinet(context)),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/maths.png',
                    height: 100,
                    width: 100,
                  ),
                  Flexible(
                    child: Text(
                      topic.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'How do you want to learn?',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Spacer(flex: 1),
              LearningModeTile(
                icon: 'assets/images/quizzes.png',
                mode: 'Quizzes',
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => CircularProgressIndicator(),
                  );

                  final questionList = await context
                      .read<StudyBuddyServices>()
                      .fetchQuizQuestions(topic.id);
                  Navigator.pop(context);
                  context.read<StudyBuddyServices>().gotoQuestion(0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizQuestionPage(
                        topic: topic.id,
                        questionList: questionList,
                      ),
                    ),
                  );
                },
              ),
              LearningModeTile(
                icon: 'assets/images/flashcards.png',
                mode: 'FlashCards',
                onPressed: () async {
                  final cardList = await context
                      .read<StudyBuddyServices>()
                      .fetchFlashcards(topic.id);
                  context.read<StudyBuddyServices>().gotoQuestion(0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlashCardPage(flashCards: cardList),
                    ),
                  );
                },
              ),
              LearningModeTile(
                icon: 'assets/images/notes.png',
                mode: 'Take Notes',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotesPage(topicId: topic.id),
                    ),
                  );
                },
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
