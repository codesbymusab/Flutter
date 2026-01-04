import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/custom_app_bar.dart';
import 'package:studdy_buddy/components/elevated_button.dart';
import 'package:studdy_buddy/components/number_card.dart';
import 'package:studdy_buddy/components/page_background.dart';
import 'package:studdy_buddy/models/quiz_answer_model.dart';
import 'package:studdy_buddy/models/quiz_question_model.dart';
import 'package:studdy_buddy/pages/quiz_question_page.dart';
import 'package:studdy_buddy/pages/quiz_result_page.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class QuizProgressPage extends StatelessWidget {
  final List<String> selectedAnswers;
  final VoidCallback onSubmit;
  const QuizProgressPage({
    super.key,
    required this.selectedAnswers,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    int attemptedCount = 0;
    for (var answer in selectedAnswers) {
      if (answer.isNotEmpty) {
        attemptedCount++;
      }
    }
    return Scaffold(
      backgroundColor: secondaryColor(context),
      appBar: CustomAppBar(
        title: Text(
          '$attemptedCount out of ${selectedAnswers.length} attempted',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.apply(color: Colors.white),
        ),
        showActionIcon: false,
      ),
      body: Background(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  for (int i = 0; i < selectedAnswers.length; i++)
                    NumberCard(
                      number: i + 1,
                      onPressed: () {
                        context.read<StudyBuddyServices>().gotoQuestion(i);
                        Navigator.pop(context);
                      },
                      color: selectedAnswers[i] != ''
                          ? selectedTileColor(context)
                          : unselectedTileColor(context),
                    ),
                ],
              ),
              Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: AppElevatedButton(onPressed: onSubmit, label: 'Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
