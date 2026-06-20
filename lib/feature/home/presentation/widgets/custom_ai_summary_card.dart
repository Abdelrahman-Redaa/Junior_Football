import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/utilities/theme_extension.dart';

class AiSummaryCard extends StatelessWidget {
  final String aiScore;
  final String skillLevel;
  final String injuryRisk;
  final VoidCallback onViewReport;

  const AiSummaryCard({
    super.key,
    required this.aiScore,
    required this.skillLevel,
    required this.injuryRisk,
    required this.onViewReport,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.primary,
            const Color(0xff1E7E34),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _AiItem(
                image: AppAssets.aIScore,
                value: aiScore,
                title: "AI Score",
              ),
              _AiItem(
                image: AppAssets.skillTwin,
                value: skillLevel,
                title: "Skill Twin",
              ),
              _AiItem(
                image: AppAssets.injuryRisk,
                value: injuryRisk,
                title: "Injury Risk",
              ),
            ],
          ),

          SizedBox(height: 10.h),
          _ViewReportButton(onTap: onViewReport),
        ],
      ),
    );
  }
}

class _AiItem extends StatelessWidget {
  final String image;
  final String value;
  final String title;

  const _AiItem({
    required this.image,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      children: [
        Image.asset(image, width: 60.w),
        SizedBox(height: 8.h),
        Text(
          value,
          style: theme.regular16.copyWith(
            color: theme.secondary,
            fontWeight: FontWeight(400),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style:theme.regular16.copyWith(
            color: theme.secondary.withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight(400),
          ),
        ),
      ],
    );
  }
}

class _ViewReportButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ViewReportButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 38.h,
        margin:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 2.h),
        decoration: BoxDecoration(
          color: theme.secondary,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "View AI Report",
              style: theme.semiBold16.copyWith(
                color: theme.primary,
                fontWeight: FontWeight(590),
              ),
            ),
            SizedBox(width: 10.w),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 15.dg,
              color: theme.primary,
            ),
          ],
        ),
      ),
    );
  }
}