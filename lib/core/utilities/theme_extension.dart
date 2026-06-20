import 'package:flutter/material.dart';
import 'package:junior_football/core/theme/theme_extension.dart';

extension ThemeExtensionX on BuildContext {
  AppThemeExtension get appTheme {
    final ext = Theme.of(this).extension<AppThemeExtension>();
    if (ext == null) {
      throw FlutterError(
        'AppThemeExtension not found in ThemeData.extensions. Make sure you add AppThemeExtension to your ThemeData (e.g., ThemeData(extensions: [appThemeExtension]))',
      );
    }
    return ext;
  }
}
