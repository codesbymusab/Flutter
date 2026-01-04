final String tableUser = 'users';

class UserFields {
  static final String id = '_id';
  static final String username = 'username';
  static final String email = 'email';
  static final String password = 'password';
  static final String joinedAt = 'joinedAt';
}

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final DateTime joinedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.joinedAt,
  });

  Map<String, Object> toJson() => {
    UserFields.id: id,
    UserFields.email: email,
    UserFields.password: password,
    UserFields.username: username,
    UserFields.joinedAt: joinedAt.toIso8601String(),
  };

  static User fromJson(Map<String, Object?> json) {
    return User(
      id: json[UserFields.id] as String,
      username: json[UserFields.username] as String,
      email: json[UserFields.email] as String,
      password: json[UserFields.password] as String,
      joinedAt: DateTime.parse(json[UserFields.joinedAt] as String),
    );
  }
}
