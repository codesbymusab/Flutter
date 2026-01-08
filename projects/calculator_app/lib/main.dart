import 'package:calculator_app/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          surface: const Color.fromARGB(255, 35, 35, 35),

          primary: const Color.fromARGB(255, 52, 52, 52),
          secondary: Colors.blueGrey,
          tertiary: const Color.fromARGB(255, 211, 223, 228),
        ),

        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontSize: 20,
            color: const Color.fromARGB(255, 211, 223, 228),
            fontWeight: FontWeight.w500,
          ),
          displayLarge: TextStyle(
            fontSize: 70,
            color: const Color.fromARGB(255, 211, 223, 228),
          ),
          displayMedium: TextStyle(
            fontSize: 40,
            color: const Color.fromARGB(255, 211, 223, 228),
          ),
          displaySmall: TextStyle(
            fontSize: 15,
            color: const Color.fromARGB(255, 211, 223, 228),
          ),
        ),
      ),
      home: MainPage(),
    );
  }
}
