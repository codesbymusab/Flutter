import 'package:expense_management_app/models/expense_model.dart';
import 'package:expense_management_app/models/income_model.dart';
import 'package:expense_management_app/models/user_model.dart';
import 'package:expense_management_app/pages/add_expense_page.dart';
import 'package:expense_management_app/pages/add_income_page.dart';
import 'package:expense_management_app/pages/home_page.dart';
import 'package:expense_management_app/pages/list_expense_page.dart';
import 'package:expense_management_app/pages/list_icome_page.dart';
import 'package:expense_management_app/pages/login_page.dart';
import 'package:expense_management_app/pages/signup_page.dart';
import 'package:expense_management_app/pages/splash_page.dart';
import 'package:expense_management_app/services/auth_services.dart';
import 'package:expense_management_app/services/fin_services.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(IncomeAdapter());
  await UserAuth.init();
  await UserAuth.setupUsers();
  await FinAuth.setupFinances();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuth>(create: (context) => UserAuth()),
        ChangeNotifierProvider<FinAuth>(create: (context) => FinAuth()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            displaySmall: TextStyle(color: Colors.white, fontSize: 17),
            titleMedium: TextStyle(color: Colors.orange, fontSize: 30),
            titleLarge: TextStyle(color: Colors.white, fontSize: 22),
            titleSmall: TextStyle(color: Colors.white, fontSize: 15),
            bodySmall: TextStyle(color: Colors.white70, fontSize: 12),
            labelSmall: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 12,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              decorationThickness: 2,
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          'login': (context) => const LoginPage(),
          'signup': (context) => const SignupPage(),
          'home_page': (context) => const HomePage(),
          'add_expense_page': (context) => AddExpensePage(),
          'add_income_page': (context) => AddIncomePage(),
          'list_income_page': (context) => ListIncomePage(),
          'list_expense_page': (context) => ListExpensePage(),
        },
      ),
    );
  }
}
