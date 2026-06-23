import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class CardContent extends StatelessWidget {
  const CardContent({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: theme.borderColor),
      ),
      child: Padding(padding: const EdgeInsets.all(8.0), child: child),
    );
  }
}
