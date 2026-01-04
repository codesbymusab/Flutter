const String tableTopics = 'topics';

class TopicFields {
  static String id = '_id';
  static String name = 'name';
  static String subjectId = 'subjectid';
  static String description = 'description';
}

class Topic {
  String id;
  String name;
  String subjectId;
  String description;

  Topic({
    required this.id,
    required this.name,
    required this.subjectId,
    required this.description,
  });

  Map<String, Object> toJson() => <String, Object>{
    TopicFields.id: id,
    TopicFields.name: name,
    TopicFields.subjectId: subjectId,
    TopicFields.description: description,
  };

  factory Topic.fromJson(Map<String, Object?> map) => Topic(
    id: map[TopicFields.id] as String,
    name: map[TopicFields.name] as String,
    subjectId: map[TopicFields.subjectId] as String,
    description: map[TopicFields.description] as String,
  );
}
