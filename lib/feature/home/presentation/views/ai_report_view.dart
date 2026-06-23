import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/feature/home/domain/entity/analysis_ai_response_entity.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utilities/theme_extension.dart';

class AiReportView extends StatelessWidget {
  const AiReportView({super.key});

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as AnalysisEntity;
    var theme = context.appTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text("aiReportView.title".tr()),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _customOverallView(context, title: arg.data.skills.overAll.toStringAsFixed(1)),

              SizedBox(height: 22.h),
              Text("aiReportView.skillsBreakdown".tr(), style: theme.semiBold24),

              SizedBox(height: 15.h),
              _skillProgressBar(
                title: "aiReportView.passing".tr(),
                percentage: arg.data.skills.passing / 100,
                context: context,
              ),

              SizedBox(height: 16.h),
              _skillProgressBar(
                title: "aiReportView.shooting".tr(),
                percentage: arg.data.skills.shooting / 100,
                context: context,
              ),

              SizedBox(height: 16.h),
              _skillProgressBar(
                title: "aiReportView.speed".tr(),
                percentage: arg.data.skills.speed / 100,
                context: context,
              ),

              SizedBox(height: 16.h),
              _skillProgressBar(
                title: "aiReportView.positioning".tr(),
                percentage: arg.data.skills.positioning / 100,
                context: context,
              ),

              SizedBox(height: 16.h),
              _skillProgressBar(
                title: "aiReportView.reaction".tr(),
                percentage: arg.data.skills.reaction / 100,
                context: context,
              ),

              SizedBox(height: 40.h),
              ElevatedButton(
                onPressed: () {
                  print(arg.data.parseScoutReport());
                  Navigator.pushNamed(
                    context,
                    AppRoutes.aiRecommendationView,
                    arguments: arg.data.parseScoutReport(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SVGAssets.iconView),
                    SizedBox(width: 5.w),
                    Text("aiReportView.viewRecommendations".tr()),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _skillProgressBar({
    required String title,
    required double percentage,
    Color backgroundColor = const Color(0xffE0E0E0),
    Color progressColor = const Color(0xff28A745),
    double height = 15,
    required BuildContext context,
  }) {
    final theme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.subTitle,
              ),
            ),
            const Spacer(),
            Text(
              "${(percentage * 100).toInt()}%",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(height),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(height),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _customOverallView(BuildContext context, {required String title}) {
    final theme = context.appTheme;
    return Container(
      width: double.infinity,
      height: 250.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: theme.primary.withValues(alpha: 0.5),
          width: 1.5.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          CircleAvatar(
            backgroundColor: theme.primary.withValues(alpha: 0.2),
            radius: 50,
            child: SvgPicture.asset(
              SVGAssets.iconView,
              colorFilter: ColorFilter.mode(theme.primary, BlendMode.srcIn),
              height: 50,
              width: 50,
            ),
          ),
          SizedBox(height: 5.h),
          Text("aiReportView.overallView".tr(), style: theme.semiBold24),
          SizedBox(height: 5.h),
          Text(
            title,
            style: theme.semiBold24.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 36,
              color: theme.primary,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            "aiReportView.outOf100".tr(),
            style: theme.medium14.copyWith(color: theme.subTitle),
          ),
        ],
      ),
    );
  }
}
