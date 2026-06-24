import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class CustomClick extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const CustomClick({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor ?? theme.primary, width: 2),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? theme.primary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
