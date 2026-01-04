import 'package:expense_management_app/constants/colors.dart';
import 'package:expense_management_app/services/auth_services.dart';
import 'package:expense_management_app/services/fin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListExpensePage extends StatefulWidget {
  const ListExpensePage({super.key});

  @override
  State<ListExpensePage> createState() => _ListExpensePageState();
}

class _ListExpensePageState extends State<ListExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: Text('Expense List'),
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer<FinAuth>(
        builder: (context, value, child) {
          final user = context.read<UserAuth>().currentUser.userName;
          final expenseList = value.getExpenseList(user);
          final int totalExpense = value.getTotalExpense(user);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Total: PKR $totalExpense',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Divider(
                  color: Colors.deepOrangeAccent,
                  indent: 5,
                  endIndent: 5,
                  radius: BorderRadius.circular(10),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: expenseList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsetsGeometry.all(20),
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 15,
                                    children: [
                                      Text(
                                        expenseList[index].category,
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        expenseList[index].description,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        'PKR ${expenseList[index].amount.toString()}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        expenseList[index].createdAt.toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              strokeAlign: BorderSide.strokeAlignOutside,
                              width: 2,
                              color: Colors.deepOrangeAccent,
                            ),
                            borderRadius: BorderRadiusGeometry.circular(10),
                          ),
                          titleTextStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                          subtitleTextStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          tileColor: Colors.white,

                          title: Text(expenseList[index].description),
                          subtitle: Text(
                            'PKR ${expenseList[index].amount.toString()}',
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              value.deleteExpense(expenseList[index]);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
