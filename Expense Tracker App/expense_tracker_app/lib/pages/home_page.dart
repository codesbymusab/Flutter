import 'package:expense_tracker_app/bar_graph/bar_graph.dart';
import 'package:expense_tracker_app/components/buttons.dart';
import 'package:expense_tracker_app/components/list_tile.dart';
import 'package:expense_tracker_app/database/expenses_db.dart';
import 'package:expense_tracker_app/helper_functions.dart';
import 'package:expense_tracker_app/model/expenses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void openNewExpenseBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5)),
            title: Text('New Expense'),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(hintText: 'Name..'),
                  ),
                  TextField(
                    controller: amountController,
                    autofocus: true,
                    decoration: InputDecoration(hintText: 'Amount..'),
                  )
                ],
              ),
            ),
            actions: [
              CancelButton(
                  nameController: nameController,
                  amountController: amountController,
                  context: context),
              SaveButton(
                  nameController: nameController,
                  amountController: amountController,
                  context: context),
            ],
          );
        });
  }

  void openEditBox(Expense expense) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5)),
            title: Text('Edit Expense'),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(hintText: expense.name),
                  ),
                  TextField(
                    controller: amountController,
                    autofocus: true,
                    decoration:
                        InputDecoration(hintText: expense.amount.toString()),
                  )
                ],
              ),
            ),
            actions: [
              CancelButton(
                  nameController: nameController,
                  amountController: amountController,
                  context: context),
              EditSaveButton(
                  nameController: nameController,
                  amountController: amountController,
                  context: context,
                  expense: expense),
            ],
          );
        });
  }

  void openDeleteBox(Expense expense) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5)),
            title: Text('Are you sure'),
            content: Text('Do you want to delete this expense?'),
            actions: [
              CancelButton(
                  nameController: nameController,
                  amountController: amountController,
                  context: context),
              DeleteButton(context: context, expense: expense),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesDb>(
      builder: (context, db, child) {
        double selectedMonthTotal = 0;
        Map<String, double> monthlyTotals = db.calculateMonthyTotals();

        List<Expense> selectedMonthExpenses = db.get().where(
          (element) {
            return element.time.year == db.selectedYear &&
                element.time.month == db.selectedMonth;
          },
        ).toList();

        for (var expense in selectedMonthExpenses) {
          selectedMonthTotal += expense.amount;
        }

        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          floatingActionButton: FloatingActionButton(
            onPressed: openNewExpenseBox,
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey.shade900,
            child: const Icon(Icons.add),
          ),
          drawer: Drawer(
            backgroundColor: Colors.grey.shade300,
            child: ListView(padding: EdgeInsets.zero, children: [
              DrawerHeader(child: Image.asset('assets/images/profile.png')),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ]),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'PKR ${selectedMonthTotal.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ColoredBox(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getCurrentMonthName(db.selectedMonth),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade200),
                    ),
                  ),
                ),
              )
            ],
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: SizedBox(
                    height: 250,
                    child: MyBarGraph(monthlySymmary: monthlyTotals)),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    itemCount: selectedMonthExpenses.length,
                    itemBuilder: (context, index) {
                      int revIndex = selectedMonthExpenses.length - index - 1;
                      final Expense currentExpense =
                          selectedMonthExpenses[revIndex];
                      return MyListTile(
                        currentExpense: currentExpense,
                        onPressedDelete: (context) =>
                            openDeleteBox(currentExpense),
                        onPressedEdit: (context) => openEditBox(currentExpense),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
