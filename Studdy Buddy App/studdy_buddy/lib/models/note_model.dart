const String tableNotes = 'notes';

class NoteFields {
  static String id = '_id';
  static String topicId = 'topic_id';
  static String title = 'title';
  static String content = 'content';
  static String createdAt = 'createdAt';
}

class Note {
  String id;
  String topicId;
  String title;
  String content;
  DateTime createdAt;

  Note({
    required this.id,
    required this.topicId,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, Object> toJson() => <String, Object>{
    NoteFields.id: id,

    NoteFields.topicId: topicId,
    NoteFields.content: content,
    NoteFields.title: title,
    NoteFields.createdAt: createdAt.toIso8601String(),
  };

  factory Note.fromJson(Map<String, Object?> map) => Note(
    id: map[NoteFields.id] as String,
    topicId: map[NoteFields.topicId] as String,
    title: map[NoteFields.title] as String,
    content: map[NoteFields.content] as String,
    createdAt: DateTime.parse(map[NoteFields.createdAt] as String),
  );
}
