import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/utilities/theme_extension.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.text1,
    required this.text2,
    this.onTap,
  });

  final String text1;
  final String text2;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: text1, style: theme.regular14),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: text2,
            style: theme.medium14.copyWith(color: theme.primary),
          ),
        ],
      ),
    );
  }
}
