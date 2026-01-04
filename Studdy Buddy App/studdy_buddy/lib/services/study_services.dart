import 'package:flutter/material.dart';
import 'package:studdy_buddy/database/app_database.dart';
import 'package:studdy_buddy/models/flashcard_model.dart';
import 'package:studdy_buddy/models/note_model.dart';
import 'package:studdy_buddy/models/quiz_answer_model.dart';
import 'package:studdy_buddy/models/quiz_model.dart';
import 'package:studdy_buddy/models/quiz_question_model.dart';
import 'package:studdy_buddy/models/reminder_model.dart';
import 'package:studdy_buddy/models/study_log_model.dart';
import 'package:studdy_buddy/models/study_session_model.dart';
import 'package:studdy_buddy/models/subject_model.dart';
import 'package:studdy_buddy/models/topic_model.dart';

class StudyBuddyServices extends ChangeNotifier {
  int _questionNo = 0;
  int _duration = 0;

  AppDatabase db = AppDatabase.instance;

  void setDuration(d) {
    _duration = d;
  }

  void incDuration() {
    _duration += 1;
  }

  int get duration => _duration;
  int get questionNo => _questionNo;

  void gotoQuestion(int i) {
    _questionNo = i;
    notifyListeners();
  }

  void nextQuestion() {
    _questionNo += 1;
    notifyListeners();
  }

  void prevQuestion() {
    _questionNo -= 1;
    notifyListeners();
  }

  Future<void> addQuiz(Quiz newQuiz) async {
    await db.insertQuiz(newQuiz.toJson());
    notifyListeners();
  }

  Future<void> addFlashCard(Flashcard newFlashCard) async {
    await db.insertFlashCard(newFlashCard.toJson());
    notifyListeners();
  }

  Future<void> addSubject(Subject newSubject) async {
    await db.insertSubject(newSubject.toJson());
    notifyListeners();
  }

  Future<void> addTopic(Topic newTopic) async {
    await db.insertTopic(newTopic.toJson());
    notifyListeners();
  }

  Future<void> addQuizAnswers(List<QuizAnswer> answers) async {
    final jsonList = answers.map((a) => a.toJson()).toList();
    await db.insertQuizAnswers(jsonList);
    notifyListeners();
  }

  Future<void> addQuizQuestions(List<QuizQuestion> questions) async {
    final jsonList = questions.map((q) => q.toJson()).toList();
    await db.insertQuestions(jsonList);
    notifyListeners();
  }

  Future<void> addNote(Note newNote) async {
    await db.insertNote(newNote.toJson());
  }

  Future<void> addReminder(Reminder newReminder) async {
    await db.insertReminder(newReminder.toJson());
    notifyListeners();
  }

  Future<void> addStudyLog(StudyLog newLog) async {
    await db.insertStudyLog(newLog.toJson());
    notifyListeners();
  }

  Future<void> addStudySession(StudySession newSession) async {
    await db.insertStudySeesion(newSession.toJson());
    notifyListeners();
  }

  Future<List<Subject>> fetchSubjects() async {
    final result = await db.getSubjects();
    return result.map((map) => Subject.fromJson(map)).toList();
  }

  Future<List<Topic>> fetchSubjectTopics(String subjectId) async {
    final result = await db.getSubjectTopics(subjectId);
    return result.map((map) => Topic.fromJson(map)).toList();
  }

  Future<Quiz> fetchTopicQuiz(String topicId) async {
    final result = await db.getTopicQuiz(topicId);
    return Quiz.fromJson(result.first);
  }

  Future<List<QuizQuestion>> fetchQuizQuestions(String quizId) async {
    final result = await db.getQuizzQuestions(quizId);
    return result.map((map) => QuizQuestion.fromJson(map)).toList();
  }

  Future<List<QuizAnswer>> fetchQuizAnswers(String questionId) async {
    final result = await db.getQuizzAnswers(questionId);
    return result.map((map) => QuizAnswer.fromJson(map)).toList();
  }

  Future<List<String>> fetchFlashcards(String topicId) async {
    final result = await db.getFlashCards(topicId);
    return result.map((id) => id[FlashcardFields.id] as String).toList();
  }

  Future<List<Note>> fetchNotes(String topicId) async {
    final result = await db.getNotes(topicId);
    return result.map((map) => Note.fromJson(map)).toList();
  }

  Future<Flashcard> getFlashCardDetails(String cardId) async {
    final result = await db.getFlashCard(cardId);
    return Flashcard.fromJson(result);
  }

  Future<List<Reminder>> fetchReminders() async {
    final result = await db.getReminders();
    return result.map((map) => Reminder.fromJson(map)).toList();
  }

  Future<List<StudyLog>> fetchStudyLogs() async {
    final result = await db.getStudyLogs();
    return result.map((map) => StudyLog.fromJson(map)).toList();
  }

  Future<List<StudySession>> fetchStudySessions() async {
    final result = await db.getStudySessions();
    return result.map((map) => StudySession.fromJson(map)).toList();
  }

  Future<void> removeNote(String id) async {
    await db.deleteNote(id);
    notifyListeners();
  }

  Future<void> initializeStudyMaterial() async {
    final List<Subject> subjectList = [
      Subject(
        id: 'sub0',
        name: 'Maths',
        description:
            'Explore numbers, patterns, and problem-solving techniques.',
        icon: 'assets/images/maths.png',
      ),
      Subject(
        id: 'sub002',
        name: 'Physics',
        description:
            'Understand the laws of nature and the mechanics of the universe.',
        icon: 'assets/images/physics.png',
      ),
      Subject(
        id: 'sub003',
        name: 'Chemistry',
        description:
            'Dive into the world of atoms, reactions, and molecular structures.',
        icon: 'assets/images/chemistry.png',
      ),
      Subject(
        id: 'sub004',
        name: 'Biology',
        description:
            'Study living organisms, ecosystems, and the science of life.',
        icon: 'assets/images/biology.png',
      ),
    ];

    final List<Topic> MathTopics = [
      Topic(
        id: 'math9_01',
        name: 'Real and Complex Numbers',
        subjectId: 'sub0',
        description:
            'Understanding number systems including real and complex numbers.',
      ),
      Topic(
        id: 'math9_02',
        name: 'Logarithms',
        subjectId: 'sub0',
        description:
            'Introduction to logarithmic expressions and their properties.',
      ),
      Topic(
        id: 'math9_03',
        name: 'Algebraic Expressions and Factorization',
        subjectId: 'sub0',
        description:
            'Manipulating algebraic expressions and applying factorization techniques.',
      ),

      Topic(
        id: 'math9_04',
        name: 'Introduction to Trigonometry',
        subjectId: 'sub0',
        description: 'Basic trigonometric ratios and their applications.',
      ),
      Topic(
        id: 'math9_05',
        name: 'Linear Equations and Inequalities',
        subjectId: 'sub0',
        description: 'Solving equations and inequalities in one variable.',
      ),
    ];

    // await db.insertQuiz(
    //   Quiz(
    //     id: 'real',
    //     topicId: 'math9_01',
    //     dateTaken: DateTime.now(),
    //     score: 0,
    //     duration: 0,
    //   ).toJson(),
    // );

    for (var subject in subjectList) {
      await db.insertSubject(subject.toJson());
    }

    for (var topic in MathTopics) {
      await db.insertTopic(topic.toJson());
    }
    // Questions
    final questions = [
      QuizQuestion(
        id: 'rn_q1',
        topicId: 'math9_01',
        questionText: 'Which of the following is an irrational number?',
      ),

      QuizQuestion(
        id: 'rn_q2',
        topicId: 'math9_01',
        questionText: 'What is the conjugate of 3 + 4i?',
      ),
      QuizQuestion(
        id: 'rn_q3',
        topicId: 'math9_01',
        questionText: 'Which number is a complex number but not real?',
      ),
      QuizQuestion(
        id: 'rn_q4',
        topicId: 'math9_01',
        questionText: 'What is the modulus of 1 - i?',
      ),
      QuizQuestion(
        id: 'rn_q5',
        topicId: 'math9_01',
        questionText: 'Which of these is a rational number?',
      ),
      QuizQuestion(
        id: 'rn_q6',
        topicId: 'math9_01',
        questionText: 'If z = 2 + 3i, what is z + z̄?',
      ),
      QuizQuestion(
        id: 'rn_q7',
        topicId: 'math9_01',
        questionText: 'What is the multiplicative inverse of 2?',
      ),
      QuizQuestion(
        id: 'rn_q8',
        topicId: 'math9_01',
        questionText: 'Which set contains 0.333...?',
      ),
      QuizQuestion(
        id: 'rn_q9',
        topicId: 'math9_01',
        questionText: 'What is (3 + 4i)(3 - 4i)?',
      ),
      QuizQuestion(
        id: 'rn_q10',
        topicId: 'math9_01',
        questionText: 'Which number is neither rational nor irrational?',
      ),
    ];

    await db.insertQuestions(
      questions.map((question) => (question.toJson())).toList(),
    );

    final answers = [
      QuizAnswer(
        id: 'rn_a1_1',
        questionId: 'rn_q1',
        answerText: '√2',
        isCorrect: true,
      ),
      QuizAnswer(
        id: 'rn_a1_2',
        questionId: 'rn_q1',
        answerText: '3/4',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a1_3',
        questionId: 'rn_q1',
        answerText: '0.75',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a1_4',
        questionId: 'rn_q1',
        answerText: '5',
        isCorrect: false,
      ),

      QuizAnswer(
        id: 'rn_a2_1',
        questionId: 'rn_q2',
        answerText: '3 - 4i',
        isCorrect: true,
      ),
      QuizAnswer(
        id: 'rn_a2_2',
        questionId: 'rn_q2',
        answerText: '-3 + 4i',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a2_3',
        questionId: 'rn_q2',
        answerText: '4 + 3i',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a2_4',
        questionId: 'rn_q2',
        answerText: '-3 - 4i',
        isCorrect: false,
      ),

      QuizAnswer(
        id: 'rn_a3_1',
        questionId: 'rn_q3',
        answerText: '0 + i',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a3_2',
        questionId: 'rn_q3',
        answerText: '5',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a3_3',
        questionId: 'rn_q3',
        answerText: '2i',
        isCorrect: true,
      ),
      QuizAnswer(
        id: 'rn_a3_4',
        questionId: 'rn_q3',
        answerText: '√9',
        isCorrect: false,
      ),

      QuizAnswer(
        id: 'rn_a4_1',
        questionId: 'rn_q4',
        answerText: '√2',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a4_2',
        questionId: 'rn_q4',
        answerText: '√(1+1)=√2',
        isCorrect: true,
      ),
      QuizAnswer(
        id: 'rn_a4_3',
        questionId: 'rn_q4',
        answerText: '2',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a4_4',
        questionId: 'rn_q4',
        answerText: '1',
        isCorrect: false,
      ),

      QuizAnswer(
        id: 'rn_a5_1',
        questionId: 'rn_q5',
        answerText: 'π',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a5_2',
        questionId: 'rn_q5',
        answerText: '7/8',
        isCorrect: true,
      ),
      QuizAnswer(
        id: 'rn_a5_3',
        questionId: 'rn_q5',
        answerText: '√3',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a5_4',
        questionId: 'rn_q5',
        answerText: 'e',
        isCorrect: false,
      ),

      QuizAnswer(
        id: 'rn_a6_1',
        questionId: 'rn_q6',
        answerText: '4',
        isCorrect: true,
      ),
      QuizAnswer(
        id: 'rn_a6_2',
        questionId: 'rn_q6',
        answerText: '2 + 3i',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a6_3',
        questionId: 'rn_q6',
        answerText: '0',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a6_4',
        questionId: 'rn_q6',
        answerText: '2i',
        isCorrect: false,
      ),

      QuizAnswer(
        id: 'rn_a7_1',
        questionId: 'rn_q7',
        answerText: '1/2',
        isCorrect: true,
      ),
      QuizAnswer(
        id: 'rn_a7_2',
        questionId: 'rn_q7',
        answerText: '2',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a7_3',
        questionId: 'rn_q7',
        answerText: '-1/2',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a7_4',
        questionId: 'rn_q7',
        answerText: '0',
        isCorrect: false,
      ),

      QuizAnswer(
        id: 'rn_a8_1',
        questionId: 'rn_q8',
        answerText: 'Rational numbers',
        isCorrect: true,
      ),
      QuizAnswer(
        id: 'rn_a8_2',
        questionId: 'rn_q8',
        answerText: 'Irrational numbers',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a8_3',
        questionId: 'rn_q8',
        answerText: 'Complex numbers',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a8_4',
        questionId: 'rn_q8',
        answerText: 'Integers',
        isCorrect: false,
      ),

      QuizAnswer(
        id: 'rn_a9_1',
        questionId: 'rn_q9',
        answerText: '25',
        isCorrect: true,
      ),
      QuizAnswer(
        id: 'rn_a9_2',
        questionId: 'rn_q9',
        answerText: '0',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a9_3',
        questionId: 'rn_q9',
        answerText: '9',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a9_4',
        questionId: 'rn_q9',
        answerText: '-7',
        isCorrect: false,
      ),

      QuizAnswer(
        id: 'rn_a10_1',
        questionId: 'rn_q10',
        answerText: 'All numbers are either rational or irrational',
        isCorrect: true,
      ),
      QuizAnswer(
        id: 'rn_a10_2',
        questionId: 'rn_q10',
        answerText: 'Imaginary numbers are neither',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a10_3',
        questionId: 'rn_q10',
        answerText: 'Zero is neither',
        isCorrect: false,
      ),
      QuizAnswer(
        id: 'rn_a10_4',
        questionId: 'rn_q10',
        answerText: 'Natural numbers are neither',
        isCorrect: false,
      ),
    ];
    await db.insertQuizAnswers(
      answers.map((answer) => (answer.toJson())).toList(),
    );
    final List<Flashcard> flashcardsReal = [
      Flashcard(
        id: 'real_f1',
        topicId: 'math9_01',
        question: 'Is √2 rational or irrational?',
        answer:
            'Irrational; it cannot be expressed as a ratio of two integers.',
        lastReviewed: DateTime.now(),
        accuracyScore: 0,
        isBookMarked: false,
      ),
      Flashcard(
        id: 'real_f2',
        topicId: 'math9_01',
        question: 'What is the conjugate of 3 + 4i?',
        answer: '3 - 4i',
        lastReviewed: DateTime.now(),
        accuracyScore: 0,
        isBookMarked: false,
      ),
      Flashcard(
        id: 'real_f3',
        topicId: 'math9_01',
        question: 'Give an example of a complex number that is not real.',
        answer: '2i (pure imaginary number), e.g., 0 + 2i',
        lastReviewed: DateTime.now(),
        accuracyScore: 0,
        isBookMarked: false,
      ),
      Flashcard(
        id: 'real_f4',
        topicId: 'math9_01',
        question: 'How do you find the modulus of 1 - i?',
        answer: 'Modulus = √(1^2 + (-1)^2) = √2',
        lastReviewed: DateTime.now(),
        accuracyScore: 0,
        isBookMarked: false,
      ),
      Flashcard(
        id: 'real_f5',
        topicId: 'math9_01',
        question: 'Which of these is rational: π, 7/8, or √3?',
        answer: '7/8 is rational; π and √3 are irrational.',
        lastReviewed: DateTime.now(),
        accuracyScore: 0,
        isBookMarked: true,
      ),
      Flashcard(
        id: 'real_f6',
        topicId: 'math9_01',
        question: 'If z = 2 + 3i, what is z + z̄?',
        answer: 'z + z̄ = (2+3i) + (2-3i) = 4',
        lastReviewed: DateTime.now(),
        accuracyScore: 0,
        isBookMarked: false,
      ),
      Flashcard(
        id: 'real_f7',
        topicId: 'math9_01',
        question: 'What is the multiplicative inverse of 2 (in rationals)?',
        answer: '1/2',
        lastReviewed: DateTime.now(),
        accuracyScore: 0,
        isBookMarked: false,
      ),
      Flashcard(
        id: 'real_f8',
        topicId: 'math9_01',
        question: 'Which set contains 0.333... (repeating)?',
        answer: 'Rational numbers (0.333... = 1/3)',
        lastReviewed: DateTime.now(),
        accuracyScore: 0,
        isBookMarked: false,
      ),
      Flashcard(
        id: 'real_f9',
        topicId: 'math9_01',
        question: 'What is (3 + 4i)(3 - 4i)?',
        answer: '(3+4i)(3-4i) = 3^2 - (4i)^2 = 9 - (-16) = 25',
        lastReviewed: DateTime.now(),
        accuracyScore: 0,
        isBookMarked: false,
      ),
      Flashcard(
        id: 'real_f10',
        topicId: 'math9_01',
        question: 'Are all numbers either rational or irrational?',
        answer: 'Yes; every real number is either rational or irrational.',
        lastReviewed: DateTime.now(),
        accuracyScore: 78,
        isBookMarked: false,
      ),
    ];
    for (var card in flashcardsReal) {
      await db.insertFlashCard(card.toJson());
    }
  }

  String getCorrectAnswer(List<QuizAnswer> answers) {
    String id = '';
    for (int i = 0; i < answers.length; i++) {
      if (answers[i].isCorrect) {
        id = answers[i].id;
        break;
      }
    }
    return id;
  }

  ({int score, String description}) evaluateQuizAnswers(
    List<String> selectedAnswers,
    List<String> correctAnswers,
  ) {
    int score = 0;
    String description = '';
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == correctAnswers[i]) {
        score++;
      }
    }
    if (score < 5) {
      description = 'Try harder next time';
    } else if (score <= 7) {
      description = 'Great Effort';
    } else {
      description = 'Congratulations';
    }
    return (score: score, description: description);
  }

  Future<void> bookmarkCard(Flashcard card) async {
    await db.setCardBookMark(card);
  }

  Future<void> updateCardLastReviewDate(Flashcard card) async {
    await db.updateCardReviewDate(card);
  }
}
