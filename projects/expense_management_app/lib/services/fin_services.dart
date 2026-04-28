import 'package:expense_management_app/models/expense_model.dart';
import 'package:expense_management_app/models/income_model.dart';

import 'package:expense_management_app/services/boxes.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class FinAuth with ChangeNotifier {
  final Box<Expense>? _expBox = Boxes.getExpenseBox();
  final Box<Income>? _incBox = Boxes.getIncomeBox();

  (int, int) _selectedDate = (DateTime.now().month, DateTime.now().year);

  static Future<void> setupFinances() async {
    if (!Hive.isBoxOpen('expense')) {
      await Hive.openBox<Expense>('expense');
    }
    if (!Hive.isBoxOpen('income')) {
      await Hive.openBox<Income>('income');
    }
  }

  Future<bool> addIncome(Income newIncome) async {
    if (_incBox == null) {
      await setupFinances();
    }
    await _incBox!.add(newIncome);
    notifyListeners();
    return true;
  }

  Future<bool> addExpense(Expense newExpense) async {
    if (_expBox == null) {
      await setupFinances();
    }
    await _expBox!.add(newExpense);
    notifyListeners();
    return true;
  }

  Future<bool> deleteIncome(Income income) async {
    if (_incBox == null) {
      await setupFinances();
    }
    await income.delete();
    notifyListeners();
    return true;
  }

  Future<bool> deleteExpense(Expense expense) async {
    if (_expBox == null) {
      await setupFinances();
    }
    await expense.delete();
    notifyListeners();
    return true;
  }

  Future<bool> editIncome(Income editIncome) async {
    if (_incBox == null) {
      await setupFinances();
    }

    await editIncome.save();
    notifyListeners();
    return true;
  }

  Future<bool> editExpense(Expense editExpense) async {
    if (_expBox == null) {
      await setupFinances();
    }
    await editExpense.save();
    notifyListeners();
    return true;
  }

  List<Expense> getExpenseList(String id) {
    if (_expBox == null) {
      setupFinances();
    }
    List<Expense> userExpenses = [];
    for (var expense in _expBox!.values) {
      if (expense.uid == id &&
          expense.createdAt.month == _selectedDate.$1 &&
          expense.createdAt.year == _selectedDate.$2) {
        userExpenses.add(expense);
      }
    }
    return userExpenses;
  }

  List<Income> getIncomeList(String id) {
    if (_incBox == null) {
      setupFinances();
    }
    List<Income> userIncomes = [];
    for (var income in _incBox!.values) {
      if (income.uid == id &&
          income.createdAt.month == _selectedDate.$1 &&
          income.createdAt.year == _selectedDate.$2) {
        userIncomes.add(income);
      }
    }
    return userIncomes;
  }

  int getTotalIncome(String id) {
    int totalIncome = 0;
    List<Income> userIncomes = getIncomeList(id);
    for (var income in userIncomes) {
      totalIncome += income.amount;
    }
    return totalIncome;
  }

  int getTotalExpense(String id) {
    int totalExpense = 0;
    List<Expense> userExpenses = getExpenseList(id);
    for (var expense in userExpenses) {
      totalExpense += expense.amount;
    }
    return totalExpense;
  }

  void changedDate(int month, int year) {
    _selectedDate = (month, year);
    notifyListeners();
  }

  (int, int) getSelectedDate() => _selectedDate;
}
