import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/provider/tasks_provider.dart';

void main() async {
  try {
    await Hive.initFlutter();
    await Hive.openBox('myBox');
  } catch (e) {
    debugPrint(e.toString());
  }
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            primary: const Color.fromARGB(255, 255, 217, 82),
            secondary: const Color.fromARGB(255, 242, 223, 155),
          ),

          textTheme: TextTheme(
            titleMedium: TextStyle(
              color: const Color.fromARGB(215, 0, 0, 0),
              fontSize: 30,
            ),
            titleSmall: TextStyle(
              color: const Color.fromARGB(215, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            bodySmall: TextStyle(
              decoration: TextDecoration.lineThrough,
              decorationColor: const Color.fromARGB(
                215,
                0,
                0,
                0,
              ), // Optional: change line color
              decorationThickness: 2.0,
              color: const Color.fromARGB(215, 0, 0, 0),
              fontSize: 20,
            ),
            displayMedium: TextStyle(
              color: const Color.fromARGB(215, 0, 0, 0),
              fontSize: 20,
            ),
            displaySmall: TextStyle(
              color: const Color.fromARGB(195, 0, 0, 0),
              fontSize: 15,
            ),
          ),
          datePickerTheme: DatePickerThemeData(
            headerBackgroundColor: const Color.fromARGB(255, 255, 217, 82),
            headerForegroundColor: const Color.fromARGB(215, 0, 0, 0),
            headerHeadlineStyle: TextStyle(
              color: const Color.fromARGB(215, 0, 0, 0),
              fontSize: 30,
            ),
            headerHelpStyle: TextStyle(
              color: const Color.fromARGB(215, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            dividerColor: Colors.black,
            todayForegroundColor: WidgetStatePropertyAll(Colors.black54),
            cancelButtonStyle: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.red),
            ),
            confirmButtonStyle: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.black),
            ),
          ),
          timePickerTheme: TimePickerThemeData(
            helpTextStyle: TextStyle(
              color: const Color.fromARGB(215, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            cancelButtonStyle: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.red),
            ),
            confirmButtonStyle: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.black),
            ),
          ),
        ),
        home: MainPage(),
      ),
    );
  }
}
