const String tableQuizQuestions = 'quiz_questions';

class QuizQuestionFields {
  static String id = '_id';
  static String topicId = 'topic_id';
  static String questionText = 'question_text';
}

class QuizQuestion {
  String id;
  String topicId;
  String questionText;

  QuizQuestion({
    required this.id,
    required this.topicId,
    required this.questionText,
  });

  Map<String, Object> toJson() => <String, Object>{
    QuizQuestionFields.id: id,
    QuizQuestionFields.topicId: topicId,
    QuizQuestionFields.questionText: questionText,
  };

  factory QuizQuestion.fromJson(Map<String, Object?> map) => QuizQuestion(
    id: map[QuizQuestionFields.id] as String,
    topicId: map[QuizQuestionFields.topicId] as String,
    questionText: map[QuizQuestionFields.questionText] as String,
  );
}
