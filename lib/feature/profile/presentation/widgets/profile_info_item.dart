import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Widget? trailing;

  const ProfileInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(color: theme.backgroundColor),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.accentSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: theme.primary, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: theme.semiBold16,
                ),
              ),
              Text(
                value,
                style: theme.medium14.copyWith(color: theme.subTitle),
              ),
              if (trailing != null) ...[const SizedBox(width: 12), trailing!],
            ],
          ),
        ),
        Divider(height: 1, color: theme.borderColor),
      ],
    );
  }
}
