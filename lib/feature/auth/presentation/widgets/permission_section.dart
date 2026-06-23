import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionSection extends StatefulWidget {
  const PermissionSection(
    this.icon, {
    super.key,
    required this.title,
    required this.subTitle,
    required this.permission,
  });

  final IconData icon;
  final String title;
  final String subTitle;
  final Permission permission;

  @override
  State<PermissionSection> createState() => _PermissionSectionState();
}

class _PermissionSectionState extends State<PermissionSection> with WidgetsBindingObserver {
  bool _isGranted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    final status = await widget.permission.status;
    setState(() {
      _isGranted = status.isGranted;
    });
  }

  Future<void> _requestPermission() async {
    final status = await widget.permission.request();
    setState(() {
      _isGranted = status.isGranted;
    });
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
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
          Switch(
            inactiveThumbColor: theme.secondary,
            inactiveTrackColor: theme.borderColor,
            value: _isGranted,
            onChanged: (value) {
              if (value) {
                _requestPermission();
              } else {
                openAppSettings();
              }
            },
          ),
        ],
      ),
    );
  }
}
