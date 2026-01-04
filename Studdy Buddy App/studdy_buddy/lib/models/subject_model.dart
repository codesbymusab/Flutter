const String tableSubjects = 'subjects';

class SubjectFields {
  static String id = '_id';
  static String name = 'name';
  static String description = 'description';
  static String icon = 'icon';
}

class Subject {
  String id;
  String name;
  String description;
  String icon;

  Subject({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });

  Map<String, Object> toJson() => <String, Object>{
    SubjectFields.id: id,
    SubjectFields.name: name,
    SubjectFields.description: description,
    SubjectFields.icon: icon,
  };

  factory Subject.fromJson(Map<String, Object?> map) => Subject(
    id: map[SubjectFields.id] as String,
    name: map[SubjectFields.name] as String,
    description: map[SubjectFields.description] as String,
    icon: map[SubjectFields.icon] as String,
  );
}
