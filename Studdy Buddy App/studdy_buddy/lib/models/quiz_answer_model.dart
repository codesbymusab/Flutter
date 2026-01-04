const String tableQuizAnswers = 'quiz_answers';

class QuizAnswerFields {
  static String id = '_id';
  static String questionId = 'question_id';
  static String answerText = 'answer_text';
  static String isCorrect = 'is_correct';
}

class QuizAnswer {
  String id;
  String questionId;
  String answerText;
  bool isCorrect;

  QuizAnswer({
    required this.id,
    required this.questionId,
    required this.answerText,
    required this.isCorrect,
  });

  Map<String, Object> toJson() => <String, Object>{
    QuizAnswerFields.id: id,
    QuizAnswerFields.questionId: questionId,
    QuizAnswerFields.answerText: answerText,
    QuizAnswerFields.isCorrect: isCorrect == true ? 1 : 0,
  };

  factory QuizAnswer.fromJson(Map<String, Object?> map) => QuizAnswer(
    id: map[QuizAnswerFields.id] as String,
    questionId: map[QuizAnswerFields.questionId] as String,
    answerText: map[QuizAnswerFields.answerText] as String,
    isCorrect: map[QuizAnswerFields.isCorrect] as int == 1 ? true : false,
  );
}
