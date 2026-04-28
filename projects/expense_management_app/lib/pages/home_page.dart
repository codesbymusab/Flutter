import 'package:expense_management_app/components/app_drawer.dart';
import 'package:expense_management_app/components/app_logo.dart';
import 'package:expense_management_app/components/date_change_menu.dart';
import 'package:expense_management_app/components/home_tile.dart';
import 'package:expense_management_app/constants/colors.dart';
import 'package:expense_management_app/models/user_model.dart';
import 'package:expense_management_app/services/auth_services.dart';
import 'package:expense_management_app/services/fin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserAuth>().setCurrentUser(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          context.read<UserAuth>().userJoinedPeriod();
          return Scaffold(
            backgroundColor: scaffoldColor,
            appBar: AppBar(
              toolbarHeight: 60,
              centerTitle: true,
              title: AppLogo(),
              backgroundColor: Colors.orangeAccent.shade400,
              leadingWidth: 200,
              leading: DateChangeMenu(),
            ),
            endDrawer: AppDrawer(user: context.read<UserAuth>().currentUser),
            body: Consumer<UserAuth>(
              builder: (context, authService, child) {
                User user = authService.currentUser;
                int totalExpense = context.watch<FinAuth>().getTotalExpense(
                  user.userName,
                );
                int totalIncome = context.watch<FinAuth>().getTotalIncome(
                  user.userName,
                );
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            'Welcome !',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.orangeAccent,
                            radius: 25,
                            child: Text(
                              user.userName[0].toUpperCase(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                      HomeTile(
                        onTap1: () {
                          Navigator.pushNamed(context, 'list_expense_page');
                        },
                        text1: 'Expense\nPKR $totalExpense',
                        onTap2: () {
                          Navigator.pushNamed(context, 'list_income_page');
                        },
                        text2: 'Income\nPKR $totalIncome',
                      ),
                      HomeTile(
                        onTap1: () {
                          Navigator.pushNamed(context, 'add_expense_page');
                        },
                        text1: 'Add an Expense',
                        onTap2: () {
                          Navigator.pushNamed(context, 'add_income_page');
                        },
                        text2: 'Add an Income',
                      ),
                      Divider(
                        color: Colors.deepOrange,
                        indent: 5,
                        endIndent: 5,
                        radius: BorderRadius.circular(10),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Income vs Expense',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            centerSpaceColor: Colors.transparent,
                            centerSpaceRadius: 50,
                            sectionsSpace: double.infinity,
                            sections: [
                              PieChartSectionData(
                                title: 'Income',
                                titleStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                value: totalIncome.toDouble(),
                                color: Colors.teal,
                              ),
                              PieChartSectionData(
                                title: 'Expense',
                                titleStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                value: totalExpense.toDouble(),

                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }
      },
    );
  }
}
