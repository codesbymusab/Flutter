import 'package:sqflite/sqflite.dart';
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
import 'package:studdy_buddy/models/user_model.dart';
import 'package:studdy_buddy/models/user_response_model.dart';

class AppDatabase {
  static AppDatabase instance = AppDatabase._init();
  AppDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('studdy_buddy_v1.4');
    return _database!;
  }

  Future<Database> _initDB(String dbPath) async {
    final filePath = await getDatabasesPath();
    final db = await openDatabase(
      filePath + dbPath,
      version: 2,
      onCreate: _createDB,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        final idType = 'TEXT PRIMARY KEY';
        final textType = 'TEXT NOT NULL';
        final intType = 'INTEGER NOT NULL';
        if (oldVersion < 2) {
          db.execute('DROP TABLE $tableNotes');
          db.execute('''
  CREATE TABLE $tableNotes(
    ${NoteFields.id} $idType,
    ${NoteFields.topicId} $textType,
    ${NoteFields.content} $textType,
    ${NoteFields.createdAt} $textType,
    ${NoteFields.title} $textType,
    FOREIGN KEY (${NoteFields.topicId}) REFERENCES $tableTopics(${TopicFields.id}) ON DELETE CASCADE
  )
''');
        }
      },
    );
    return db;
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'TEXT PRIMARY KEY';
    final textType = 'TEXT NOT NULL';
    final intType = 'INTEGER NOT NULL';
    try {
      db.execute('''
    CREATE TABLE $tableUsers(
    ${UserFields.id} $idType,
    ${UserFields.username} $textType,
    ${UserFields.email} $textType,
    ${UserFields.password} $textType,
    ${UserFields.joinedAt} $textType

    )''');

      db.execute('''
  CREATE TABLE $tableSubjects(
    ${SubjectFields.id} $idType,
    ${SubjectFields.name} $textType,
    ${SubjectFields.description} $textType,
    ${SubjectFields.icon} $textType
  )
''');

      db.execute('''
  CREATE TABLE $tableTopics(
    ${TopicFields.id} $idType,
    ${TopicFields.name} $textType,
    ${TopicFields.subjectId} $textType,
    ${TopicFields.description} $textType,
    FOREIGN KEY (${TopicFields.subjectId}) REFERENCES $tableSubjects(${SubjectFields.id}) ON DELETE CASCADE
  )
''');

      db.execute('''
  CREATE TABLE $tableQuizzes(
    ${QuizFields.id} $idType,
    ${QuizFields.topicId} $textType,
    ${QuizFields.dateTaken} $textType,
    ${QuizFields.score} $intType,
    ${QuizFields.duration} $intType,
    FOREIGN KEY (${QuizFields.topicId}) REFERENCES $tableTopics(${TopicFields.id}) ON DELETE CASCADE
  )
''');

      db.execute('''
  CREATE TABLE $tableFlashcards(
  
    ${FlashcardFields.id} $idType,
    ${FlashcardFields.topicId} $textType,
    ${FlashcardFields.question} $textType,
    ${FlashcardFields.answer} $textType,
    ${FlashcardFields.lastReviewed} $textType,
    ${FlashcardFields.accuracyScore} $intType,
    ${FlashcardFields.isBookMarked} $intType,
    FOREIGN KEY (${FlashcardFields.topicId}) REFERENCES $tableTopics(${TopicFields.id}) ON DELETE CASCADE
  )
''');

      db.execute('''
  CREATE TABLE $tableQuizQuestions(
    ${QuizQuestionFields.id} $idType,
    ${QuizQuestionFields.topicId} $textType,
    ${QuizQuestionFields.questionText} $textType,
    FOREIGN KEY (${QuizQuestionFields.topicId}) REFERENCES $tableTopics(${TopicFields.id}) ON DELETE CASCADE
  )
''');

      db.execute('''
  CREATE TABLE $tableQuizAnswers(
    ${QuizAnswerFields.id} $idType,
    ${QuizAnswerFields.questionId} $textType,
    ${QuizAnswerFields.answerText} $textType,
    ${QuizAnswerFields.isCorrect} $intType,
    FOREIGN KEY (${QuizAnswerFields.questionId}) REFERENCES $tableQuizQuestions(${QuizQuestionFields.id}) ON DELETE CASCADE
  )
''');

      db.execute('''
  CREATE TABLE $tableNotes(
    ${NoteFields.id} $idType,
    ${NoteFields.topicId} $textType,
    ${NoteFields.content} $textType,
    ${NoteFields.createdAt} $textType,
    ${NoteFields.title} $textType,
    FOREIGN KEY (${NoteFields.topicId}) REFERENCES $tableTopics(${TopicFields.id}) ON DELETE CASCADE
  )
''');

      db.execute('''
  CREATE TABLE $tableStudySessions(
    ${StudySessionFields.id} $idType,
    ${StudySessionFields.topicId} $textType,
    ${StudySessionFields.startTime} $textType,
    ${StudySessionFields.endTime} $textType,
    ${StudySessionFields.duration} $intType,
    FOREIGN KEY (${StudySessionFields.topicId}) REFERENCES $tableTopics(${TopicFields.id}) ON DELETE CASCADE
  )
''');

      db.execute('''
  CREATE TABLE $tableStudyLogs(
    ${StudyLogFields.id} $idType,
    ${StudyLogFields.date} $textType,
    ${StudyLogFields.topicId} $textType,
    ${StudyLogFields.duration} $intType,
    FOREIGN KEY (${StudyLogFields.topicId}) REFERENCES $tableTopics(${TopicFields.id}) ON DELETE CASCADE
  )
''');

      db.execute('''
    CREATE TABLE $tableResponses(
    ${UserResponseFields.id} $idType,
    ${UserResponseFields.quizId} $textType,
    ${UserResponseFields.selectedAnswerId} $textType
    )''');

      db.execute('''
    CREATE TABLE $tableReminders(
    ${ReminderFields.id} $idType,
    ${ReminderFields.isRecurring} $intType,
    ${ReminderFields.message} $textType,
    ${ReminderFields.scheduledTime} $textType
    )''');
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> insertUser(Map<String, Object> json) async {
    final db = await database;
    db.insert(tableUsers, json);
  }

  Future<void> insertQuiz(Map<String, Object> json) async {
    final db = await database;
    db.insert(tableQuizzes, json);
  }

  Future<void> insertFlashCard(Map<String, Object> json) async {
    final db = await database;
    db.insert(tableFlashcards, json);
  }

  Future<void> insertSubject(Map<String, Object> json) async {
    final db = await database;
    db.insert(tableSubjects, json);
  }

  Future<void> insertTopic(Map<String, Object> json) async {
    final db = await database;
    db.insert(tableTopics, json);
  }

  Future<void> insertQuizAnswers(List<Map<String, Object>> jsonList) async {
    final db = await database;
    for (var json in jsonList) {
      db.insert(tableQuizAnswers, json);
    }
  }

  Future<void> insertQuestions(List<Map<String, Object>> jsonList) async {
    final db = await database;
    for (var json in jsonList) {
      db.insert(tableQuizQuestions, json);
    }
  }

  Future<void> insertNote(Map<String, Object> json) async {
    final db = await database;
    db.insert(tableNotes, json);
  }

  Future<void> insertReminder(Map<String, Object> json) async {
    final db = await database;

    db.insert(tableReminders, json);
  }

  Future<void> insertStudyLog(Map<String, Object> json) async {
    final db = await database;

    db.insert(tableStudyLogs, json);
  }

  Future<void> insertStudySeesion(Map<String, Object> json) async {
    final db = await database;

    db.insert(tableStudySessions, json);
  }

  Future<List<Map<String, Object?>>> readCurrentUser(String id) async {
    final db = await database;
    return await db.query(
      tableUsers,
      where: '${UserFields.id}=?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, Object?>>> readUser(
    String email,
    String password,
  ) async {
    final db = await database;
    return await db.query(
      tableUsers,
      where: '${UserFields.email}=? AND ${UserFields.password}=?',
      whereArgs: [email, password],
    );
  }

  Future<List<Map<String, Object?>>> getSubjects() async {
    final db = await database;
    return await db.query(tableSubjects);
  }

  Future<List<Map<String, Object?>>> getSubjectTopics(String subjectId) async {
    final db = await database;
    return await db.query(
      tableTopics,
      where: '${TopicFields.subjectId}=?',
      whereArgs: [subjectId],
    );
  }

  Future<List<Map<String, Object?>>> getTopicQuiz(String topicId) async {
    final db = await database;
    return await db.query(
      tableQuizzes,
      where: '${QuizFields.topicId}=?',
      whereArgs: [topicId],
    );
  }

  Future<List<Map<String, Object?>>> getQuizzQuestions(String topicId) async {
    final db = await database;
    return await db.query(
      tableQuizQuestions,
      where: '${QuizQuestionFields.topicId}=?',
      whereArgs: [topicId],
    );
  }

  Future<List<Map<String, Object?>>> getQuizzAnswers(String questionId) async {
    final db = await database;
    return await db.query(
      tableQuizAnswers,
      where: '${QuizAnswerFields.questionId}=?',
      whereArgs: [questionId],
    );
  }

  Future<List<Map<String, Object?>>> getFlashCards(String topicId) async {
    final db = await database;
    return await db.query(
      tableFlashcards,
      columns: [FlashcardFields.id],
      where: '${FlashcardFields.topicId}=?',
      whereArgs: [topicId],
    );
  }

  Future<List<Map<String, Object?>>> getNotes(String topicId) async {
    final db = await database;

    return await db.query(
      tableNotes,
      where: '${NoteFields.topicId}=?',
      whereArgs: [topicId],
    );
  }

  Future<Map<String, Object?>> getFlashCard(String id) async {
    final db = await database;
    final result = await db.query(
      tableFlashcards,
      where: '${FlashcardFields.id}=?',
      whereArgs: [id],
    );
    return result.first;
  }

  Future<void> setCardBookMark(Flashcard card) async {
    final db = await database;
    await db.update(
      tableFlashcards,
      {FlashcardFields.isBookMarked: card.isBookMarked == false ? 1 : 0},
      where: '${FlashcardFields.id}=?',
      whereArgs: [card.id],
    );
  }

  Future<void> updateCardReviewDate(Flashcard card) async {
    final db = await database;
    await db.update(
      tableFlashcards,
      {FlashcardFields.lastReviewed: DateTime.now().toIso8601String()},
      where: '${FlashcardFields.id}=?',
      whereArgs: [card.id],
    );
  }

  Future<void> updateNote(Note note) async {
    final db = await database;
    await db.update(
      tableNotes,
      {NoteFields.content: note.content},
      where: '${NoteFields.id}=?',
      whereArgs: [note.id],
    );
  }

  Future<List<Map<String, Object?>>> getReminders() async {
    final db = await database;
    return await db.query(tableReminders);
  }

  Future<List<Map<String, Object?>>> getStudyLogs() async {
    final db = await database;
    return await db.query(tableStudyLogs);
  }

  Future<List<Map<String, Object?>>> getStudySessions() async {
    final db = await database;
    return await db.query(tableStudySessions);
  }

  Future<void> deleteNote(String id) async {
    final db = await database;
    await db.delete(tableNotes, where: '${NoteFields.id}=?', whereArgs: [id]);
  }

  Future<void> deleteSubject() async {
    final db = await database;
    await db.delete(tableSubjects);
  }
}
