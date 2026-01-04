const String tableFlashcards = 'flashcards';

class FlashcardFields {
  static String id = '_id';
  static String topicId = 'topic_id';
  static String question = 'question';
  static String answer = 'answer';
  static String lastReviewed = 'last_reviewed';
  static String accuracyScore = 'accuracy_score';
  static String isBookMarked = 'bookmarked';
}

class Flashcard {
  String id;
  String topicId;
  String question;
  String answer;
  DateTime lastReviewed;
  int accuracyScore;
  bool isBookMarked;

  Flashcard({
    required this.id,
    required this.topicId,
    required this.question,
    required this.answer,
    required this.lastReviewed,
    required this.accuracyScore,
    required this.isBookMarked,
  });

  Map<String, Object> toJson() => <String, Object>{
    FlashcardFields.id: id,
    FlashcardFields.topicId: topicId,
    FlashcardFields.question: question,
    FlashcardFields.answer: answer,
    FlashcardFields.lastReviewed: lastReviewed.toIso8601String(),
    FlashcardFields.accuracyScore: accuracyScore,
    FlashcardFields.isBookMarked: isBookMarked == true ? 1 : 0,
  };

  factory Flashcard.fromJson(Map<String, Object?> map) => Flashcard(
    id: map[FlashcardFields.id] as String,
    topicId: map[FlashcardFields.topicId] as String,
    question: map[FlashcardFields.question] as String,
    answer: map[FlashcardFields.answer] as String,
    lastReviewed: DateTime.parse(map[FlashcardFields.lastReviewed] as String),
    accuracyScore: map[FlashcardFields.accuracyScore] as int,
    isBookMarked: map[FlashcardFields.isBookMarked] as int == 1 ? true : false,
  );
}
