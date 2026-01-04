import 'package:expense_management_app/components/add_item.dart';
import 'package:expense_management_app/constants/colors.dart';
import 'package:expense_management_app/models/expense_model.dart';
import 'package:expense_management_app/services/auth_services.dart';
import 'package:expense_management_app/services/fin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  var expenseCategories = [
    'Housing',
    'Transportation',
    'Food and Groceries',
    'Healthcare',
    'Debt Payments',
    'Entertainment',
    'Personal Care',
    'Clothing and Accessories',
    'Utilities and Bills',
    'Savings and Investments',
    'Education',
    'Travel',
  ];

  @override
  Widget build(BuildContext context) {
    void onPressedAdd() async {
      if (_amountController.text.isNotEmpty &&
          _descController.text.isNotEmpty) {
        final Expense expense = Expense(
          id: Uuid().v1(),
          uid: context.read<UserAuth>().currentUser.userName,
          category: _categoryController.text,
          description: _descController.text,
          amount: int.parse(_amountController.text),
          createdAt: DateTime.now(),
        );
        await context.read<FinAuth>().addExpense(expense);

        setState(() {
          _amountController.clear();
          _descController.clear();
          _categoryController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Expense added successfully!',
                style: TextStyle(color: Colors.deepOrangeAccent),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        });
      }
    }

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Add an Expense'),
      ),
      body: AddItem(
        categoryController: _categoryController,
        descController: _descController,
        amountController: _amountController,
        onPressed: onPressedAdd,
        categories: expenseCategories,
        label: 'Add Expense',
        color: Colors.deepOrange,
      ),
    );
  }
}
