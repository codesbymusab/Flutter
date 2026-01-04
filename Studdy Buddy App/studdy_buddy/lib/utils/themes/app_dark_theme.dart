import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studdy_buddy/utils/themes/app_light_theme.dart';

const Color primaryColorDark = Color(0xFF2E3C62);
const Color secondaryColorDark = Color(0xFFF85187);
const Color primaryLightColorDark = Color.fromARGB(255, 243, 41, 105);
const Color primaryContainerColorDark = Color(0xFF2E3C62);
const Color primaryTileColorDark = Color(0xFFF85187);
const Color secondaryTileColorDark = Color.fromARGB(255, 85, 111, 182);
final Color correctColorDark = Colors.greenAccent.shade700;
final Color incorrectColorDark = Colors.redAccent.shade700;
const Color elevationColorDark = Colors.white;
const mainGradientDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[primaryColorDark, primaryLightColorDark],
);

const List<Color> notesColorsDark = [
  Color.fromRGBO(140, 0, 255, 1),
  Color.fromRGBO(255, 196, 0, 1),
  Color(0xFFF85187),
  Color.fromRGBO(180, 229, 13, 1),
];

TextTheme darkTextTheme() => GoogleFonts.quicksandTextTheme(
  TextTheme(
    bodyLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    bodyMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    bodySmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 25,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 40,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 15,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: primaryLightColorDark,
      fontSize: 15,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: primaryColorDark,
      fontSize: 25,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 15,
    ),
  ),
);
IconThemeData darkIconTheme() => IconThemeData(color: Colors.white, size: 16);

ThemeData darkTheme() => ThemeData.dark().copyWith(
  textTheme: darkTextTheme(),
  iconTheme: darkIconTheme(),
);
