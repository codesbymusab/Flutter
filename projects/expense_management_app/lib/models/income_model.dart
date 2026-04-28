import 'package:hive_flutter/hive_flutter.dart';

part 'income_model.g.dart';

@HiveType(typeId: 2)
class Income extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String uid;
  @HiveField(2)
  late int amount;
  @HiveField(3)
  late String description;
  @HiveField(4)
  late String category;
  @HiveField(5)
  late DateTime createdAt;
  Income({
    required this.id,
    required this.uid,
    required this.category,
    required this.description,
    required this.amount,
    required this.createdAt,
  });
}
