const String tableResponses = 'userresponses';

class UserResponseFields {
  static String id = '_id';
  static String quizId = 'quizid';
  static String selectedAnswerId = 'answerid';
}

class UserResponse {
  String id;
  String quizId;
  String selectedAnswerId;

  UserResponse({
    required this.id,
    required this.quizId,
    required this.selectedAnswerId,
  });

  Map<String, Object> toMap() => <String, Object>{
    UserResponseFields.id: id,
    UserResponseFields.quizId: quizId,
    UserResponseFields.selectedAnswerId: selectedAnswerId,
  };

  factory UserResponse.fromMap(Map<String, Object?> map) => UserResponse(
    id: map[UserResponseFields.id] as String,
    quizId: map[UserResponseFields.quizId] as String,
    selectedAnswerId: map[UserResponseFields.selectedAnswerId] as String,
  );
}
