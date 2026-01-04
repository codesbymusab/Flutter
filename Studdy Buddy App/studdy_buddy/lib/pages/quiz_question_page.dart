import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class QuizQuestionPage extends StatefulWidget {
  final String topic;
  final List<QuizQuestion> questionList;
  const QuizQuestionPage({
    super.key,
    required this.topic,
    required this.questionList,
  });

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  late final List<String> selectedAnswers;
  late final List<String> correctAnswers;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<String>.filled(widget.questionList.length, '');
    correctAnswers = List<String>.filled(widget.questionList.length, '?');
  }

  @override
  Widget build(BuildContext context) {
    int questionNo = context.watch<StudyBuddyServices>().questionNo;

    bool isFirstQuestion() => questionNo == 0;
    bool isLastQuestion() => questionNo == widget.questionList.length - 1;
    void gotoResultPage() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultPage(
            topic: widget.topic,
            questionList: widget.questionList,
            selectedAnswers: selectedAnswers,
            correctAnswers: correctAnswers,
            duration: context.read<StudyBuddyServices>().duration,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: secondaryColor(context),
      appBar: CustomAppBar(
        title: Text(
          'Q.${questionNo + 1}',
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.apply(color: Colors.white),
        ),
        showActionIcon: true,
        leading: AppTimer(seconds: 900, onTimerFinished: gotoResultPage),
        onMenuActionTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizProgressPage(
                selectedAnswers: selectedAnswers,
                onSubmit: gotoResultPage,
              ),
            ),
          );
        },
      ),
      body: Background(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              widget.questionList[questionNo].questionText,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            FutureBuilder(
              future: context.read<StudyBuddyServices>().fetchQuizAnswers(
                widget.questionList[questionNo].id,
              ),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  correctAnswers[questionNo] = context
                      .read<StudyBuddyServices>()
                      .getCorrectAnswer(asyncSnapshot.data!);

                  return Column(
                    children: [
                      for (int i = 0; i < 4; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: AnswerTile(
                            answer: asyncSnapshot.data![i].answerText,
                            option: '${String.fromCharCode(97 + i)}.',
                            onTap: () {
                              setState(() {
                                if (selectedAnswers[questionNo] ==
                                    asyncSnapshot.data![i].id) {
                                  selectedAnswers[questionNo] = '';
                                } else {
                                  selectedAnswers[questionNo] =
                                      asyncSnapshot.data![i].id;
                                }
                              });
                            },
                            selected:
                                selectedAnswers[questionNo] ==
                                    asyncSnapshot.data![i].id
                                ? true
                                : false,
                          ),
                        ),
                    ],
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
            Spacer(),
            Expanded(
              child: Row(
                spacing: 10,
                children: [
                  isFirstQuestion()
                      ? SizedBox()
                      : Container(
                          decoration: BoxDecoration(
                            color: secondaryColor(context),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              context.read<StudyBuddyServices>().prevQuestion();
                            },
                          ),
                        ),

                  isLastQuestion()
                      ? Expanded(
                          child: AppElevatedButton(
                            onPressed: gotoResultPage,
                            label: 'Submit',
                          ),
                        )
                      : Expanded(
                          child: AppElevatedButton(
                            onPressed: () {
                              context.read<StudyBuddyServices>().nextQuestion();
                            },
                            label: 'Next',
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
