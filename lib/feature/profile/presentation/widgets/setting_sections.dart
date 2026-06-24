import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/theme/theme_cubit.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/profile/presentation/widgets/card_content.dart';
import 'package:junior_football/feature/profile/presentation/view_model/profile_view_model.dart';
import 'package:junior_football/feature/profile/presentation/views/change_password_view.dart';
import 'package:junior_football/feature/profile/presentation/views/support_view.dart';

class SettingSections extends StatelessWidget {
  const SettingSections({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SettingsTile(
          title: 'settings.changePassword'.tr(),
          desc: 'settings.changePasswordDesc'.tr(),
          icon: Icons.lock_outline,
          onTap: () {
            final vm = context.read<ProfileViewModel>();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: vm,
                  child: const ChangePasswordView(),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          title: 'settings.support'.tr(),
          desc: 'settings.supportDesc'.tr(),
          icon: Icons.support_agent_outlined,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SupportView()),
            );
          },
        ),
        const SizedBox(height: 12),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return _SettingsToggleTile(
              title: 'settings.darkMode'.tr(),
              desc: 'settings.darkModeDesc'.tr(),
              icon: Icons.dark_mode_outlined,
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                context.read<ThemeCubit>().setDarkMode(value);
              },
            );
          },
        ),
        const SizedBox(height: 12),
        _SettingsToggleTile(
          title: 'settings.arabicLanguage'.tr(),
          desc: 'settings.arabicLanguageDesc'.tr(),
          icon: Icons.language_outlined,
          value: context.locale.languageCode == 'ar',
          onChanged: (value) async {
            if (value) {
              await context.setLocale(const Locale('ar'));
            } else {
              await context.setLocale(const Locale('en'));
            }
          },
        ),
        const SizedBox(height: 12),
        _LogoutTile(onLogout: onLogout),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    required this.desc,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String desc;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return CardContent(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: theme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: theme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.semiBold16),
                  const SizedBox(height: 4),
                  Text(
                    desc,
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
      ),
    );
  }
}

class _SettingsToggleTile extends StatelessWidget {
  const _SettingsToggleTile({
    required this.title,
    required this.desc,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String desc;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

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
            child: Icon(icon, color: theme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.semiBold16),
                const SizedBox(height: 4),
                Text(
                  desc,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.medium14.copyWith(color: theme.subTitle),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: theme.primary,
          ),
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
                    'settings.logout'.tr(),
                    style: theme.semiBold16.copyWith(color: theme.red),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'settings.logoutDesc'.tr(),
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
