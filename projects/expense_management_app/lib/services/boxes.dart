import 'package:expense_management_app/models/expense_model.dart';
import 'package:expense_management_app/models/income_model.dart';
import 'package:expense_management_app/models/user_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<User> getUserBox() => Hive.box<User>('user');
  static Box<Expense> getExpenseBox() => Hive.box<Expense>('expense');
  static Box<Income> getIncomeBox() => Hive.box<Income>('income');
}
