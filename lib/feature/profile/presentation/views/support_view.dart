import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/profile/presentation/widgets/card_content.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Scaffold(
      appBar: AppBar(title: Text('support.title'.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VerticalSpace(32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.support_agent_rounded,
                size: 80,
                color: theme.primary,
              ),
            ),
            VerticalSpace(24),
            Text('support.howCanWeHelp'.tr(), style: theme.semiBold24),
            VerticalSpace(8),
            Text(
              'support.getInTouch'.tr(),
              style: theme.regular14.copyWith(color: theme.subTitle),
            ),
            VerticalSpace(32),
            CardContent(
              child: Column(
                children: [
                  _buildContactRow(
                    context,
                    icon: Icons.person_outline,
                    title: 'support.developerName'.tr(),
                    value: 'support.developerNameValue'.tr(),
                  ),
                  const Divider(height: 32),
                  _buildContactRow(
                    context,
                    icon: Icons.work_outline,
                    title: 'support.title_label'.tr(),
                    value: 'support.titleValue'.tr(),
                  ),
                  const Divider(height: 32),
                  _buildContactRow(
                    context,
                    icon: Icons.email_outlined,
                    title: 'support.email'.tr(),
                    value: "aabdelrahmanreda666@gmail.com",
                    onTap: () =>
                        _launchUrl('mailto:aabdelrahmanreda666@gmail.com'),
                    showArrow: true,
                  ),
                  const Divider(height: 32),
                  _buildContactRow(
                    context,
                    icon: Icons.phone_outlined,
                    title: 'support.phone'.tr(),
                    value: "01027271938",
                    onTap: () => _launchUrl('tel:01027271938'),
                    showArrow: true,
                  ),
                ],
              ),
            ),
            VerticalSpace(16),
            CardContent(
              child: Column(
                children: [
                  _buildContactRow(
                    context,
                    icon: Icons.link,
                    title: 'support.linkedIn'.tr(),
                    value: 'support.linkedInValue'.tr(),
                    onTap: () => _launchUrl(
                      'https://www.linkedin.com/in/abdelrahman-redaa?utm_source=share_via&utm_content=profile&utm_medium=member_android',
                    ),
                    showArrow: true,
                  ),
                  const Divider(height: 32),
                  _buildContactRow(
                    context,
                    icon: Icons.code,
                    title: 'support.github'.tr(),
                    value: 'support.githubValue'.tr(),
                    onTap: () => _launchUrl(
                      'https://github.com/Abdelrahman-Redaa/Junior_Football.git',
                    ),
                    showArrow: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
    bool showArrow = false,
  }) {
    final theme = context.appTheme;

    Widget content = Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: theme.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.regular14.copyWith(color: theme.subTitle),
              ),
              const SizedBox(height: 2),
              Text(value, style: theme.semiBold16),
            ],
          ),
        ),
        if (showArrow)
          Icon(Icons.chevron_right, color: theme.subTitle, size: 20),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: content,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: content,
    );
  }
}
