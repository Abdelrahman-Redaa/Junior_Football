import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utilities/theme_extension.dart';

class TrainingCard extends StatelessWidget {
  final String title;
  final String duration;
  final String level;
  final double progress;
  final VoidCallback onTap;

  const TrainingCard({
    super.key,
    required this.title,
    required this.duration,
    required this.level,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Card(
      elevation: 0,
      color: theme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: theme.borderColor),
      ),
      child: Padding(
        padding:  EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(title: title, progress: progress),

            SizedBox(height: 6.h),

            _SubTitle(duration: duration, level: level),

             SizedBox(height: 12.h),

            _ProgressBar(progress: progress),

             SizedBox(height: 12.h),

            _StartButton(onTap: onTap),

             SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final double progress;

  const _Header({
    required this.title,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Row(
      children: [
        Text(
          title,
          style: theme.regular18.copyWith(color: theme.surface),
        ),
        const Spacer(),
        Text(
          "${(progress * 100).toInt()}%",
          style: theme.regular18.copyWith(
            color: theme.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _SubTitle extends StatelessWidget {
  final String duration;
  final String level;

  const _SubTitle({
    required this.duration,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Text(
      "$duration • $level",
      style: theme.regular14.copyWith(
        color: theme.subTitle,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;

  const _ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 10,
        backgroundColor: theme.progressTrack,
        valueColor: AlwaysStoppedAnimation(theme.primary),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  final VoidCallback onTap;

  const _StartButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
          color: theme.primary,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, size: 20, color: theme.secondary),
            SizedBox(width: 4.w),
            Text(
              "Start Training",
              style: theme.semiBold16.copyWith(
                color: theme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}