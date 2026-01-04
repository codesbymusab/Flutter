import 'package:flutter/material.dart';
import 'package:studdy_buddy/utils/themes/app_dark_theme.dart';
import 'package:studdy_buddy/utils/themes/app_light_theme.dart';
import 'package:studdy_buddy/utils/themes/ui_parameters.dart';

LinearGradient mainGradinet(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? mainGradientDark
    : mainGradientLight;

ThemeData themeData(BuildContext context) =>
    UIParameters.isDarkMode(context) == true ? darkTheme() : lightTheme();

Color primaryContainerColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? primaryContainerColorDark
    : primaryContainerColorLight;

Color primaryTileColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? primaryTileColorDark
    : primaryTileColorLight;

Color unselectedTileColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? secondaryTileColorDark
    : primaryTileColorLight;

Color selectedTileColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? primaryTileColorDark
    : secondaryTileColorLight;

Color primaryColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? primaryColorDark
    : primaryColorLight;

Color secondaryColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? secondaryColorDark
    : primaryColorLight;

Color primaryLightColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? primaryLightColorDark
    : primaryLightColorLight;

Color correctColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? correctColorDark
    : correctColorLight;

Color incorrrectColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? incorrectColorDark
    : incorrectColorLight;

Color elevationColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? elevationColorDark
    : elevationColorLight;

List<Color> notesColor(BuildContext context) =>
    UIParameters.isDarkMode(context) == true
    ? notesColorsDark
    : noteColorsLight;
