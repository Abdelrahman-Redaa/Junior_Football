import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class PermissionSection extends StatefulWidget {
  const PermissionSection(
    this.icon, {
    super.key,
    required this.title,
    required this.subTitle,
  });

  final IconData icon;
  final String title;
  final String subTitle;

  @override
  State<PermissionSection> createState() => _PermissionSectionState();
}

class _PermissionSectionState extends State<PermissionSection> {
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final ValueNotifier<bool> isSwitched = ValueNotifier(false);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 7,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(widget.icon, color: theme.neutral),
                VerticalSpace(12),
                Text(widget.title, style: theme.semiBold24),
                VerticalSpace(9),
                Text(
                  maxLines: 3,
                  widget.subTitle,
                  style: theme.medium14.copyWith(color: theme.subTitle),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isSwitched,
            builder: (context, value, child) {
              return Switch(
                inactiveThumbColor: theme.secondary,
                inactiveTrackColor: theme.borderColor,
                value: value,
                onChanged: (value) {
                  isSwitched.value = value;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
