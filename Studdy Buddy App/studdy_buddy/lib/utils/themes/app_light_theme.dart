import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryLightColorLight = Color(0xFF3AC3CB);
const Color primaryColorLight = Color(0xFFF85187);

const Color primaryContainerColorLight = Color.fromARGB(255, 247, 228, 250);
const Color primaryTileColorLight = Colors.white;
const Color secondaryTileColorLight = Color.fromARGB(255, 92, 247, 255);
const Color correctColorLight = Colors.greenAccent;
const Color incorrectColorLight = Colors.redAccent;
const Color elevationColorLight = Color.fromARGB(255, 0, 180, 245);
const List<Color> noteColorsLight = [
  Color.fromRGBO(205, 143, 238, 1), // Soft lilac — gentle violet tint
  Color.fromRGBO(255, 255, 255, 1), // Pale amber — warm and readable
  Color.fromRGBO(255, 187, 225, 1), // Blush pink — soft and friendly
  Color.fromRGBO(158, 207, 212, 1),
];

const mainGradientLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[primaryLightColorLight, primaryColorLight],
);

TextTheme lightTextTheme() => GoogleFonts.quicksandTextTheme(
  TextTheme(
    bodyLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
    bodyMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
    bodySmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 25,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      fontSize: 40,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      fontSize: 20,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      fontSize: 15,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: primaryLightColorLight,
      fontSize: 15,
    ),

    labelMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: primaryColorLight,
      fontSize: 25,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 15,
    ),
  ),
);
IconThemeData lightIconTheme() =>
    IconThemeData(color: Colors.black87, size: 16);

ThemeData lightTheme() => ThemeData.light().copyWith(
  textTheme: lightTextTheme(),
  iconTheme: lightIconTheme(),
);
