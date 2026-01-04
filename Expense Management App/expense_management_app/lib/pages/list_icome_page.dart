import 'package:expense_management_app/constants/colors.dart';
import 'package:expense_management_app/services/auth_services.dart';
import 'package:expense_management_app/services/fin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListIncomePage extends StatefulWidget {
  const ListIncomePage({super.key});

  @override
  State<ListIncomePage> createState() => _ListIncomePageState();
}

class _ListIncomePageState extends State<ListIncomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: Text('Income List'),
        backgroundColor: Colors.teal.shade300,
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
          final incomeList = value.getIncomeList(user);
          final int totalIncome = value.getTotalIncome(user);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Total: PKR $totalIncome',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Divider(
                  color: Colors.tealAccent,
                  indent: 5,
                  endIndent: 5,
                  radius: BorderRadius.circular(10),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: incomeList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              strokeAlign: BorderSide.strokeAlignOutside,
                              width: 2,
                              color: Colors.tealAccent,
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

                          title: Text(incomeList[index].description),
                          subtitle: Text(
                            'PKR ${incomeList[index].amount.toString()}',
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              value.deleteIncome(incomeList[index]);
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
