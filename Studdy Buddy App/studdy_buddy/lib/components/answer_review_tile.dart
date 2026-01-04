import 'package:flutter/material.dart';
import 'package:studdy_buddy/models/quiz_answer_model.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class AnswerReviewTile extends StatelessWidget {
  final String option;
  final QuizAnswer answer;
  final bool? attemptedCorrect;
  const AnswerReviewTile({
    super.key,
    required this.answer,
    required this.option,
    required this.attemptedCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
            side: BorderSide(
              width: 2.5,
              strokeAlign: BorderSide.strokeAlignInside,
              color: attemptedCorrect != null
                  ? attemptedCorrect!
                        ? correctColor(context)
                        : incorrrectColor(context)
                  : answer.isCorrect
                  ? correctColor(context)
                  : Colors.transparent,
            ),
          ),
          tileColor: unselectedTileColor(context),
          leading: Text(
            option,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          title: Text(
            answer.answerText,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
