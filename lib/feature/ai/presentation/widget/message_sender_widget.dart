import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class MessageSenderWidget extends StatelessWidget {
  const MessageSenderWidget({
    super.key,
    required this.message,
    required this.isUser,
  });
  final String message;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: isUser
          ? _userMessage(context, message)
          : _aiMessage(context, message),
    );
  }

  Widget _aiMessage(BuildContext context, String message) {
    final theme = context.appTheme;
    return Container(
      padding: EdgeInsets.only(bottom: 17, top: 7, right: 14, left: 14),
      constraints: BoxConstraints(maxWidth: 266),
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: MarkdownBody(
        data: message,
        styleSheet: MarkdownStyleSheet(
          p:   theme.medium14.copyWith(color: theme.surface),
          strong: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _userMessage(BuildContext context, String message) {
    final theme = context.appTheme;
    return Container(
      padding: EdgeInsets.only(bottom: 17, top: 7, right: 14, left: 14),
      constraints: BoxConstraints(maxWidth: 266),
      decoration: BoxDecoration(
        color: theme.accentSurface,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Text(
        message,
        style: theme.medium14.copyWith(color: theme.textColor),
      ),
    );
  }
}
