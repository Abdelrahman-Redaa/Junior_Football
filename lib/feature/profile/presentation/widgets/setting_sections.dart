import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/profile/presentation/widgets/card_content.dart';

class SettingSections extends StatelessWidget {
  const SettingSections({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final items = _ProfileModel.profile;

    return Column(
      children: [
        ...List.generate(
          items.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SettingsTile(item: items[index]),
          ),
        ),
        _LogoutTile(onLogout: onLogout),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.item});

  final _ProfileModel item;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return CardContent(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: theme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, color: theme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: theme.semiBold16),
                const SizedBox(height: 4),
                Text(
                  item.desc,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.medium14.copyWith(color: theme.subTitle),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: theme.subTitle),
        ],
      ),
    );
  }
}

class _LogoutTile extends StatelessWidget {
  const _LogoutTile({required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return CardContent(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onLogout,
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: theme.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.logout, color: theme.red),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logout',
                    style: theme.semiBold16.copyWith(color: theme.red),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sign out from this account',
                    style: theme.medium14.copyWith(color: theme.subTitle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileModel {
  final String title;
  final String desc;
  final IconData icon;

  const _ProfileModel({
    required this.title,
    required this.desc,
    required this.icon,
  });

  static const List<_ProfileModel> profile = [
    _ProfileModel(
      title: 'Account',
      desc: 'Security, phone number, and profile data',
      icon: Icons.person_outline_rounded,
    ),
    _ProfileModel(
      title: 'Privacy',
      desc: 'Blocked contacts and visibility controls',
      icon: Icons.lock_outline,
    ),
    _ProfileModel(
      title: 'About',
      desc: 'App info and version',
      icon: Icons.error_outline,
    ),
    _ProfileModel(
      title: 'Support',
      desc: 'Help center, contact us, and privacy policy',
      icon: Icons.help_outline,
    ),
  ];
}
