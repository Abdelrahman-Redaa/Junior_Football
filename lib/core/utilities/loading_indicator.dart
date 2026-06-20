import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return CircularProgressIndicator(
      backgroundColor: theme.primary,
      color: Colors.white,
      strokeWidth: 2,
      trackGap: 10,
    );
  }
}
