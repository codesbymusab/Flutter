const String tableQuizzes = 'quizzes';

class QuizFields {
  static String id = '_id';
  static String topicId = 'topic_id';
  static String dateTaken = 'date_taken';
  static String score = 'score';
  static String duration = 'duration';
}

class Quiz {
  String id;
  String topicId;
  DateTime dateTaken;
  int score;
  int duration;

  Quiz({
    required this.id,
    required this.topicId,
    required this.dateTaken,
    required this.score,
    required this.duration,
  });

  Map<String, Object> toJson() => <String, Object>{
    QuizFields.id: id,
    QuizFields.topicId: topicId,
    QuizFields.dateTaken: dateTaken.toIso8601String(),
    QuizFields.score: score,
    QuizFields.duration: duration,
  };

  factory Quiz.fromJson(Map<String, Object?> map) => Quiz(
    id: map[QuizFields.id] as String,
    topicId: map[QuizFields.topicId] as String,
    dateTaken: DateTime.parse(map[QuizFields.dateTaken] as String),
    score: map[QuizFields.score] as int,
    duration: map[QuizFields.duration] as int,
  );
}
