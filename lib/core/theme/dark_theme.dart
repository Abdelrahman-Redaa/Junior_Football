import 'package:flutter/material.dart';
import 'package:junior_football/core/theme/app_textstyles.dart';
import 'package:junior_football/core/theme/app_theme.dart';
import 'package:junior_football/core/theme/theme_extension.dart';

class DarkTheme extends AppTheme {
  @override
  AppColors get color => _DarkColors();

  @override
  ThemeData get themeData => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: color.primary,
      surface: color.backgroundColor,
      onSurface: color.textColor,
    ),
    inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonThemeData,
    scaffoldBackgroundColor: color.backgroundColor,
    cardTheme: CardThemeData(
      color: color.backgroundColor,
      elevation: 0,
    ),
    extensions: [appThemeExtension],
    appBarTheme: appBarTheme,
    fontFamily: 'Nunito',
    outlinedButtonTheme: outlinedButtonThemeData,
    primaryColor: color.primary,
    switchTheme: SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        return const Color(0xFF3A3A3A);
      }),
    ),
    dividerColor: color.borderColor,
  );

  @override
  ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledForegroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 46),
          backgroundColor: color.primary,
          foregroundColor: color.surface,
          textStyle: appThemeExtension.semiBold16,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    hintFadeDuration: const Duration(seconds: 1),
    fillColor: const Color(0xFF2A2A2A),
    filled: true,
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
      borderSide: BorderSide(color: color.primary),
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
    iconTheme: IconThemeData(size: 20, color: color.surface),
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
          padding: const EdgeInsets.symmetric(vertical: 12),
          minimumSize: const Size(double.infinity, 46),
        ),
      );
}

class _DarkColors extends AppColors {
  @override
  Color get backgroundColor => const Color(0xFF1C1C1C);

  @override
  Color get borderColor => const Color(0xFF3A3A3A);

  @override
  Color get primary => const Color(0xFF28A745);

  @override
  Color get red => const Color(0xFFFF3B30);

  @override
  Color get secondary => const Color(0xFF2A2A2A);

  @override
  Color get surface => const Color(0xFFFFFFFF);

  @override
  Color get textColor => const Color(0xFFFFFFFF);

  @override
  Color get yellow => const Color(0xFFFFCC00);

  @override
  Color get grey => const Color(0xFF9CA3AF);

  @override
  Color get error => const Color(0xFFFF6B6B);

  @override
  Color get subTitle => const Color(0xFFB0B0B0);

  @override
  Color get neutral => const Color(0xFF979797);
}
