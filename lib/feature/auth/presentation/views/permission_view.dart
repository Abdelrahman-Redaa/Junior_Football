import 'package:flutter/material.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/auth/presentation/widgets/permission_section.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionView extends StatelessWidget {
  const PermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
        child: Text(
          textAlign: TextAlign.center,
          maxLines: 2,
          "You can manage the permissions anytime in your device settings ",
          style: theme.medium14.copyWith(color: theme.subTitle),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Permission Needed", style: theme.semiBold28),
              VerticalSpace(8),
              Text(
                "Grant access to these features to get the most out Junior Football",
                textAlign: TextAlign.center,
                style: theme.regular16.copyWith(color: theme.subTitle),
              ),
              VerticalSpace(42),
              PermissionSection(
                Icons.camera_alt_rounded,
                title: "Camera",
                subTitle:
                    'Record your training sessions for AI-powered performance video recording',
                permission: Permission.camera,
              ),
              VerticalSpace(22),
              PermissionSection(
                Icons.folder,
                title: "Storage",
                subTitle:
                    'Save and access your recorded training videos and AI reports.',
                permission: Permission.storage,
              ),
              VerticalSpace(69),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.bottomNavigationView,
                    (route) => false,
                  );
                },
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
