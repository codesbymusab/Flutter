const String tableStudySessions = 'study_sessions';

class StudySessionFields {
  static String id = '_id';
  static String topicId = 'topic_id';
  static String startTime = 'start_time';
  static String endTime = 'end_time';
  static String duration = 'duration';
}

class StudySession {
  String id;
  String topicId;
  DateTime startTime;
  DateTime endTime;
  int duration;

  StudySession({
    required this.id,
    required this.topicId,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });

  Map<String, Object> toJson() => <String, Object>{
    StudySessionFields.id: id,
    StudySessionFields.topicId: topicId,
    StudySessionFields.startTime: startTime.toIso8601String(),
    StudySessionFields.endTime: endTime.toIso8601String(),
    StudySessionFields.duration: duration,
  };

  factory StudySession.fromJson(Map<String, Object?> map) => StudySession(
    id: map[StudySessionFields.id] as String,
    topicId: map[StudySessionFields.topicId] as String,
    startTime: DateTime.parse(map[StudySessionFields.startTime] as String),
    endTime: DateTime.parse(map[StudySessionFields.endTime] as String),
    duration: map[StudySessionFields.duration] as int,
  );
}
