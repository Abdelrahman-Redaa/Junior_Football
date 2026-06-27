import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/constants/keys.dart';
import 'package:junior_football/core/utilities/app_local_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  Future<void> loadTheme() async {
    final isDark = await AppLocalStorage.getBool(AppKeys.darkMode);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> setDarkMode(bool isDark) async {
    await AppLocalStorage.set(AppKeys.darkMode, isDark);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
