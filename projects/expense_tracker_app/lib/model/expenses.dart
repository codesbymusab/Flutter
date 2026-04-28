import 'package:hive/hive.dart';

part 'expenses.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late double amount;
  @HiveField(2)
  late DateTime time;
}
