import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

final class ShowToastMessage {
  ShowToastMessage._();

  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    final theme = context.appTheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.semiBold16.copyWith(
            color: theme.secondary,
            fontSize: 14,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        backgroundColor: isError
            ? theme.red.withValues(alpha: 0.8)
            : theme.primary,
      ),
    );
  }
}
