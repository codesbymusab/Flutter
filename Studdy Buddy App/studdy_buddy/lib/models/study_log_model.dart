const String tableStudyLogs = 'study_logs';

class StudyLogFields {
  static String id = '_id';
  static String date = 'date';
  static String topicId = 'topic_id';
  static String duration = 'duration';
}

class StudyLog {
  String id;
  DateTime date;
  String topicId;
  int duration;

  StudyLog({
    required this.id,
    required this.date,
    required this.topicId,
    required this.duration,
  });

  Map<String, Object> toJson() => <String, Object>{
    StudyLogFields.id: id,
    StudyLogFields.date: date.toIso8601String(),
    StudyLogFields.topicId: topicId,
    StudyLogFields.duration: duration,
  };

  factory StudyLog.fromJson(Map<String, Object?> map) => StudyLog(
    id: map[StudyLogFields.id] as String,
    date: DateTime.parse(map[StudyLogFields.date] as String),
    topicId: map[StudyLogFields.topicId] as String,
    duration: map[StudyLogFields.duration] as int,
  );
}
