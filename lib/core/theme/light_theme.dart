import 'package:flutter/material.dart';
import 'package:junior_football/core/theme/app_textstyles.dart';
import 'package:junior_football/core/theme/app_theme.dart';
import 'package:junior_football/core/theme/theme_extension.dart';

class LightTheme extends AppTheme {
  @override
  AppColors get color => _LightColors();

  @override
  ThemeData get themeData => ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.light(primary: color.primary),
    inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonThemeData,
    scaffoldBackgroundColor: color.backgroundColor,
    cardTheme: CardThemeData(
      color: color.backgroundColor,
      elevation: 0,
    ),
    extensions: [appThemeExtension],
    appBarTheme: appBarTheme,
    fontFamily: "Nunito",
    outlinedButtonTheme: outlinedButtonThemeData,
    primaryColor: color.primary,
    switchTheme: SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        return Color(0xFFE9E9EA);
      }),
    ),
  );

  @override
  ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledForegroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 46),
          backgroundColor: color.primary,
          foregroundColor: color.secondary,
          textStyle: appThemeExtension.semiBold16,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    hintFadeDuration: Duration(seconds: 1),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color.borderColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color.error),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color.borderColor),
    ),
    hintStyle: appThemeExtension.medium14.copyWith(color: color.grey),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color.borderColor),
    ),
  );

  @override
  AppThemeExtension get appThemeExtension => AppThemeExtension(
    regular24: AppTextStyles.regular14.copyWith(color: color.textColor),
    regular18: AppTextStyles.regular18.copyWith(color: color.textColor),
    regular22: AppTextStyles.regular22.copyWith(color: color.textColor),
    regular16: AppTextStyles.regular16.copyWith(color: color.textColor),
    regular14: AppTextStyles.regular14.copyWith(color: color.textColor),
    semiBold16: AppTextStyles.semiBold16.copyWith(color: color.textColor),
    semiBold28: AppTextStyles.semiBold28.copyWith(color: color.textColor),
    semiBold24: AppTextStyles.semiBold24.copyWith(color: color.textColor),
    medium14: AppTextStyles.medium14.copyWith(color: color.textColor),
    primary: color.primary,
    secondary: color.secondary,
    surface: color.surface,
    backgroundColor: color.backgroundColor,
    textColor: color.textColor,
    borderColor: color.borderColor,
    yellow: color.yellow,
    red: color.red,
    grey: color.grey,
    subTitle: color.subTitle,
    neutral: color.neutral,
  );

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: color.backgroundColor,
    foregroundColor: color.surface,
    elevation: 0,
    scrolledUnderElevation: 0,
    iconTheme: const IconThemeData(size: 20, color: Colors.black),
    titleTextStyle: appThemeExtension.semiBold24.copyWith(color: color.surface),
    centerTitle: true,
  );

  @override
  OutlinedButtonThemeData get outlinedButtonThemeData =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: appThemeExtension.semiBold16,
          foregroundColor: color.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: BorderSide(color: color.primary),
          padding: EdgeInsets.symmetric(vertical: 12),
          minimumSize: Size(double.infinity, 46),
        ),
      );
}

class _LightColors extends AppColors {
  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get borderColor => Color(0xFFD9D9D9);

  @override
  Color get primary => Color(0xFF28A745);

  @override
  Color get red => Color(0xFFFF3B30);

  @override
  Color get secondary => Color(0xFFFFFFFF);

  @override
  Color get surface => Color(0xFF1C1C1C);

  @override
  Color get textColor => Colors.black;

  @override
  Color get yellow => Color(0xFFFFCC00);

  @override
  Color get grey => Color(0xFF6A707C);
  @override
  Color get error => Colors.red;

  @override
  Color get subTitle => Color(0xFF494949);

  @override
  Color get neutral => Color(0xFF979797);
}
