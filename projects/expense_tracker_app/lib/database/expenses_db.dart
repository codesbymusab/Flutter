import 'package:expense_tracker_app/model/expenses.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class ExpensesDb extends ChangeNotifier {
  final _box = Boxes.getExpenses();
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  static Future<void> setupExpenses() async {
    await Hive.openBox<Expense>('expenses');
  }

  List<Expense> get() => _box.values.toList();

  void addExpense(String name, String amount, DateTime time) {
    Expense newExpense = Expense();
    newExpense.amount = double.parse(amount);
    newExpense.name = name;
    newExpense.time = time;
    _box.add(newExpense);
    notifyListeners();
  }

  void editExpense({
    required Expense editExpense,
    required String name,
    required String amount,
  }) {
    editExpense.amount = double.parse(amount);
    editExpense.name = name;
    editExpense.save();
    notifyListeners();
  }

  void deleteExpense(Expense expense) {
    expense.delete();
    notifyListeners();
  }

  Map<String, double> calculateMonthyTotals() {
    Map<String, double> monthlyTotals = {};
    final expenseList = get();

    for (var expense in expenseList) {
      final int month = expense.time.month;
      final int year = expense.time.year;
      if (!monthlyTotals.keys.contains('$month,$year')) {
        monthlyTotals['$month,$year'] = 0;
      }
      monthlyTotals['$month,$year'] =
          monthlyTotals['$month,$year']! + expense.amount;
    }
    return monthlyTotals;
  }

  int getStartingMonth() {
    final expenseList = get();

    if (expenseList.isEmpty) {
      return DateTime.now().month;
    }

    expenseList.sort((a, b) => a.time.compareTo(b.time));
    return expenseList.first.time.month;
  }

  int getStartingYear() {
    final expenseList = get();

    if (expenseList.isEmpty) {
      return DateTime.now().year;
    }

    expenseList.sort((a, b) => a.time.compareTo(b.time));
    return expenseList.first.time.year;
  }

  void selectMonth(int monthNo) {
    selectedMonth = monthNo;
    notifyListeners();
  }
}

class Boxes {
  static Box<Expense> getExpenses() => Hive.box('expenses');
}
