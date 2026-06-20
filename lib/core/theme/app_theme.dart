import 'package:flutter/material.dart';
import 'package:junior_football/core/theme/theme_extension.dart';

abstract class AppColors {
  Color get primary;
  Color get secondary;
  Color get surface;
  Color get backgroundColor;
  Color get textColor;

  Color get borderColor;
  Color get yellow;
  Color get red;
  Color get grey;
  Color get error;

  Color get subTitle;
  Color get neutral;
}

abstract class AppTheme {
  AppColors get color;
  AppThemeExtension get appThemeExtension;
  ThemeData get themeData;
  OutlinedButtonThemeData get outlinedButtonThemeData;
  ElevatedButtonThemeData get elevatedButtonThemeData;
  InputDecorationTheme get inputDecorationTheme;
  AppBarTheme get appBarTheme;
}
