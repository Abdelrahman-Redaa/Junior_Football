import 'package:flutter/material.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  //>>>>>>>>>>>>>>>TextStyles<<<<<<<<<<<<<<<<//
  final TextStyle regular24;
  final TextStyle regular18;
  final TextStyle regular22;
  final TextStyle regular16;
  final TextStyle regular14;
  final TextStyle semiBold16;
  final TextStyle semiBold28;
  final TextStyle semiBold24;
  final TextStyle medium14;

  //>>>>>>>>>>>>>>>Colors<<<<<<<<<<<<<<<<//
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color backgroundColor;
  final Color textColor;

  final Color borderColor;
  final Color yellow;
  final Color red;
  final Color grey;
  final Color subTitle;
  final Color neutral;

  AppThemeExtension({
    required this.regular24,
    required this.regular18,
    required this.regular22,
    required this.regular16,
    required this.regular14,
    required this.semiBold16,
    required this.semiBold28,
    required this.semiBold24,
    required this.medium14,
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.yellow,
    required this.red,
    required this.grey,
    required this.subTitle,
    required this.neutral,
  });

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    final TextStyle? regular24,
    final TextStyle? regular18,
    final TextStyle? regular22,
    final TextStyle? regular16,
    final TextStyle? regular14,
    final TextStyle? semiBold16,
    final TextStyle? semiBold28,
    final TextStyle? semiBold24,
    final TextStyle? medium14,

    //>>>>>>>>>>>>>>>Colors<<<<<<<<<<<<<<<<//
    final Color? primary,
    final Color? secondary,
    final Color? surface,
    final Color? backgroundColor,
    final Color? textColor,

    final Color? borderColor,
    final Color? yellow,
    final Color? red,
    final Color? grey,
    final Color? subTitle,
    final Color? neutral,
  }) {
    return AppThemeExtension(
      regular24: regular24 ?? this.regular24,
      regular18: regular18 ?? this.regular18,
      regular22: regular22 ?? this.regular22,
      regular16: regular16 ?? this.regular16,
      regular14: regular14 ?? this.regular14,
      semiBold16: semiBold16 ?? this.semiBold16,
      semiBold28: semiBold28 ?? this.semiBold28,
      semiBold24: semiBold24 ?? this.semiBold24,
      medium14: medium14 ?? this.medium14,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      borderColor: borderColor ?? this.borderColor,
      yellow: yellow ?? this.yellow,
      red: red ?? this.red,
      grey: grey ?? this.grey,
      subTitle: subTitle ?? this.subTitle,
      neutral: neutral ?? this.neutral,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      regular24: TextStyle.lerp(regular24, other.regular24, t)!,
      regular18: TextStyle.lerp(regular18, other.regular18, t)!,
      regular22: TextStyle.lerp(regular22, other.regular22, t)!,
      regular16: TextStyle.lerp(regular16, other.regular16, t)!,
      regular14: TextStyle.lerp(regular14, other.regular14, t)!,
      semiBold16: TextStyle.lerp(semiBold16, other.semiBold16, t)!,
      semiBold28: TextStyle.lerp(semiBold28, other.semiBold28, t)!,
      semiBold24: TextStyle.lerp(semiBold24, other.semiBold24, t)!,
      medium14: TextStyle.lerp(medium14, other.medium14, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      red: Color.lerp(red, other.red, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      subTitle: Color.lerp(subTitle, other.subTitle, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
    );
  }
}
