import 'package:expense_management_app/components/add_item.dart';
import 'package:expense_management_app/constants/colors.dart';
import 'package:expense_management_app/models/income_model.dart';
import 'package:expense_management_app/services/auth_services.dart';
import 'package:expense_management_app/services/fin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  var incomeCategories = [
    'Salary/Wages',
    'Freelance/Consulting',
    'Investment Income',
    'Business Income',
    'Side Hustle',
    'Pension/Retirement',
    'Alimony/Child Support',
    'Gifts/Inheritance',
    'Royalties',
    'Savings Withdrawal',
    'Bonus/Incentives',
    'Commissions',
    'Grants/Scholarships',
    'Rental Income',
    'Dividends',
  ];

  @override
  Widget build(BuildContext context) {
    void onPressedAdd() async {
      if (_amountController.text.isNotEmpty &&
          _descController.text.isNotEmpty) {
        final Income income = Income(
          id: Uuid().v1(),
          uid: context.read<UserAuth>().currentUser.userName,
          category: _categoryController.text,
          description: _descController.text,
          amount: int.parse(_amountController.text),
          createdAt: DateTime.now(),
        );
        await context.read<FinAuth>().addIncome(income);

        setState(() {
          _amountController.clear();
          _descController.clear();
          _categoryController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Income added successfully!',
                style: TextStyle(color: Colors.teal.shade300),
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
        backgroundColor: Colors.teal.shade300,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Add an Income'),
      ),
      body: AddItem(
        categoryController: _categoryController,
        descController: _descController,
        amountController: _amountController,
        onPressed: onPressedAdd,
        categories: incomeCategories,
        label: 'Add Income',
        color: Colors.teal,
      ),
    );
  }
}
