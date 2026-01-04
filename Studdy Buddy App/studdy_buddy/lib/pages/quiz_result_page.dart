import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/custom_app_bar.dart';
import 'package:studdy_buddy/components/elevated_button.dart';
import 'package:studdy_buddy/components/page_background.dart';
import 'package:studdy_buddy/components/number_card.dart';
import 'package:studdy_buddy/models/quiz_model.dart';
import 'package:studdy_buddy/models/quiz_question_model.dart';
import 'package:studdy_buddy/pages/quiz_question_page.dart';
import 'package:studdy_buddy/pages/quiz_review_page.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:uuid/uuid.dart';

class QuizResultPage extends StatelessWidget {
  final String topic;
  final List<QuizQuestion> questionList;
  final List<String> selectedAnswers;
  final List<String> correctAnswers;
  final int duration;
  const QuizResultPage({
    super.key,
    required this.topic,
    required this.questionList,
    required this.selectedAnswers,
    required this.correctAnswers,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final result = context.read<StudyBuddyServices>().evaluateQuizAnswers(
      selectedAnswers,
      correctAnswers,
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          '  ${result.score} out of ${questionList.length} are correct',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.apply(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pushNamed(context, 'MainPage');
          },
        ),
        showActionIcon: false,
      ),
      backgroundColor: secondaryColor(context),
      body: Background(
        body: Column(
          spacing: 10,
          children: [
            SvgPicture.asset(
              'assets/images/bulb.svg',
              height: 120,

              colorFilter: ColorFilter.mode(
                primaryLightColor(context),
                BlendMode.srcIn,
              ),
            ),
            FittedBox(
              child: Text(
                result.description,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
              'You have got ${result.score} points',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.apply(color: secondaryColor(context)),
            ),

            Text(
              'Tap below question numbers to view correct answer',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < questionList.length; i++)
                      NumberCard(
                        number: i + 1,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizReviewPage(
                                questionNo: i + 1,
                                question: questionList[i],
                                selectedAnswer: selectedAnswers[i],
                              ),
                            ),
                          );
                        },
                        color: selectedAnswers[i] == correctAnswers[i]
                            ? correctColor(context)
                            : incorrrectColor(context),
                      ),
                  ],
                ),
              ),
            ),
            Spacer(),

            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: AppElevatedButton(
                    onPressed: () async {
                      final quiz = Quiz(
                        id: Uuid().v1(),
                        topicId: topic,
                        dateTaken: DateTime.now(),
                        score: result.score,
                        duration: duration,
                      );
                      await context.read<StudyBuddyServices>().addQuiz(quiz);
                      context.read<StudyBuddyServices>().gotoQuestion(0);
                      context.read<StudyBuddyServices>().setDuration(0);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizQuestionPage(
                            topic: topic,
                            questionList: questionList,
                          ),
                        ),
                      );
                    },
                    backgroundColor: unselectedTileColor(context),
                    label: 'Try Again',
                    labelStyle: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Expanded(
                  child: AppElevatedButton(
                    onPressed: () async {
                      final quiz = Quiz(
                        id: Uuid().v1(),
                        topicId: topic,
                        dateTaken: DateTime.now(),
                        score: result.score,
                        duration: duration,
                      );
                      await context.read<StudyBuddyServices>().addQuiz(quiz);
                      Navigator.pushReplacementNamed(context, 'MainPage');
                    },
                    label: 'Go to Home',
                    labelStyle: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
