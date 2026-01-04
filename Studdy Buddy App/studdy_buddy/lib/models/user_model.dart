const String tableUsers = 'users';

class UserFields {
  static String id = '_id';
  static String username = 'username';
  static String email = 'email';
  static String password = 'password';
  static String joinedAt = 'joined';
}

class User {
  String id;
  String username;
  String email;
  String password;
  DateTime joinedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.joinedAt,
  });

  Map<String, Object> toJson() => <String, Object>{
    UserFields.id: id,
    UserFields.username: username,
    UserFields.email: email,
    UserFields.password: password,
    UserFields.joinedAt: joinedAt.toIso8601String(),
  };

  factory User.fromJson(Map<String, Object?> map) => User(
    id: map[UserFields.id] as String,
    username: map[UserFields.username] as String,
    email: map[UserFields.email] as String,
    password: map[UserFields.password] as String,
    joinedAt: DateTime.parse(map[UserFields.joinedAt] as String),
  );
}
