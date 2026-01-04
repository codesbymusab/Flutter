import 'package:expense_tracker_app/database/expenses_db.dart';
import 'package:expense_tracker_app/model/expenses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
    required this.nameController,
    required this.amountController,
    required this.context,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController amountController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          nameController.clear();
          amountController.clear();
          Navigator.pop(context);
        },
        child: Text('Cancel'));
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.context,
    required this.expense,
  }) : super(key: key);

  final BuildContext context;
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.read<ExpensesDb>().deleteExpense(expense);
          Navigator.pop(context);
        },
        child: Text('Delete', style: TextStyle(color: Colors.red)));
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.nameController,
    required this.amountController,
    required this.context,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController amountController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (nameController.text.isNotEmpty &&
              amountController.text.isNotEmpty) {
            context.read<ExpensesDb>().addExpense(
                nameController.text, amountController.text, DateTime.now());
            nameController.clear();
            amountController.clear();
            Navigator.pop(context);
          }
        },
        child: Text('Save'));
  }
}

class EditSaveButton extends StatelessWidget {
  const EditSaveButton({
    Key? key,
    required this.nameController,
    required this.amountController,
    required this.context,
    required this.expense,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController amountController;
  final BuildContext context;
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (nameController.text.isNotEmpty ||
              amountController.text.isNotEmpty) {
            context.read<ExpensesDb>().editExpense(
                editExpense: expense,
                name: nameController.text.isNotEmpty
                    ? nameController.text
                    : expense.name,
                amount: amountController.text.isNotEmpty
                    ? amountController.text
                    : expense.amount.toString());
            nameController.clear();
            amountController.clear();
            Navigator.pop(context);
          }
        },
        child: Text('Save'));
  }
}
