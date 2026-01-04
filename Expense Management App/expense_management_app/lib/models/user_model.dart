import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String userName;
  @HiveField(2)
  late String email;
  @HiveField(3)
  late String password;
  @HiveField(4)
  late DateTime joinedAt;

  User({
    required this.id,
    required this.email,
    required this.userName,
    required this.password,
  });
}
