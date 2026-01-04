import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/answer_review_tile.dart';
import 'package:studdy_buddy/components/background_painter.dart';
import 'package:studdy_buddy/components/custom_app_bar.dart';
import 'package:studdy_buddy/components/elevated_button.dart';
import 'package:studdy_buddy/components/form_elevated_button.dart';
import 'package:studdy_buddy/components/answer_tile.dart';
import 'package:studdy_buddy/components/page_background.dart';
import 'package:studdy_buddy/components/timer.dart';
import 'package:studdy_buddy/models/quiz_answer_model.dart';
import 'package:studdy_buddy/models/quiz_question_model.dart';
import 'package:studdy_buddy/models/topic_model.dart';
import 'package:studdy_buddy/pages/quiz_progress_page.dart';
import 'package:studdy_buddy/pages/quiz_result_page.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class QuizReviewPage extends StatelessWidget {
  final int questionNo;
  final QuizQuestion question;
  final String selectedAnswer;
  const QuizReviewPage({
    super.key,
    required this.questionNo,
    required this.question,
    required this.selectedAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor(context),
      appBar: CustomAppBar(
        title: Text(
          'Q.${questionNo + 1}',
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.apply(color: Colors.white),
        ),

        showActionIcon: false,
      ),
      body: Background(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              question.questionText,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            FutureBuilder(
              future: context.read<StudyBuddyServices>().fetchQuizAnswers(
                question.id,
              ),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  return Expanded(
                    child: Column(
                      children: [
                        for (int i = 0; i < 4; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),

                            child: AnswerReviewTile(
                              answer: asyncSnapshot.data![i],
                              option: '${String.fromCharCode(97 + i)}.',
                              attemptedCorrect:
                                  selectedAnswer == asyncSnapshot.data![i].id
                                  ? asyncSnapshot.data![i].isCorrect
                                        ? true
                                        : false
                                  : null,
                            ),
                          ),
                      ],
                    ),
                  );
                } else if (asyncSnapshot.hasError) {
                  throw Exception('Error');
                } else {
                  return SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor(context),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
