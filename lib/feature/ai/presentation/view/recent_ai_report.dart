import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/utilities/spaces.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/ai/domain/entity/recent_report_entity.dart';
import 'package:junior_football/feature/ai/presentation/view_model/ai_state.dart';
import 'package:junior_football/feature/ai/presentation/view_model/ai_view_model.dart';

class RecentAiReport extends StatelessWidget {
  const RecentAiReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ai.recentHistory'.tr()),
      ),
      body: SafeArea(
        child: BlocBuilder<AiViewModel, AiState>(
          builder: (context, state) {
            if (state.recentReport?.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator());
            }

            final reports = state.recentReport?.data ?? [];

            if (reports.isEmpty) {
              return Center(
                child: Text(
                  'recentAiReport.noReports'.tr(),
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return CardRecentItem(report: reports[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class CardRecentItem extends StatelessWidget {
  final RecentAiReportEntity report;

  const CardRecentItem({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.drillType,
                      style: theme.semiBold16.copyWith(fontSize: 18.sp),
                    ),
                    const VerticalSpace(4),
                    Text(
                      report.createdAt,
                      style: theme.regular14.copyWith(color: theme.grey),
                    ),
                  ],
                ),
              ),
              _buildScoreBadge(context, report.overallScore),
            ],
          ),
          const VerticalSpace(16),
          _buildSkillsSummary(context, report.skills),
          const VerticalSpace(16),
          Divider(color: theme.borderColor, thickness: 1),
          const VerticalSpace(12),
          _buildSimilarPlayer(context, report),
        ],
      ),
    );
  }

  Widget _buildScoreBadge(BuildContext context, int score) {
    final theme = context.appTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: theme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        '$score%',
        style: theme.semiBold16.copyWith(color: theme.primary),
      ),
    );
  }

  Widget _buildSkillsSummary(BuildContext context, SkillsEntity skills) {
    return Column(
      children: [
        _buildSkillItem(context, 'aiReportView.speed'.tr(), skills.speed),
        const VerticalSpace(8),
        _buildSkillItem(context, 'aiReportView.shooting'.tr(), skills.shooting),
        const VerticalSpace(8),
        _buildSkillItem(context, 'aiReportView.passing'.tr(), skills.passing),
        const VerticalSpace(8),
        _buildSkillItem(context, 'aiReportView.positioning'.tr(), skills.positioning),
        const VerticalSpace(8),
        _buildSkillItem(context, 'aiReportView.reaction'.tr(), skills.reaction),
      ],
    );
  }

  Widget _buildSkillItem(BuildContext context, String label, int value) {
    final theme = context.appTheme;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: theme.medium14.copyWith(color: theme.subTitle),
          ),
        ),
        Expanded(
          flex: 6,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 8.h,
              backgroundColor: theme.borderColor.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
            ),
          ),
        ),
        const HorizontalSpace(12),
        SizedBox(
          width: 32.w,
          child: Text(
            '$value',
            style: theme.semiBold16.copyWith(fontSize: 14.sp),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarPlayer(
    BuildContext context,
    RecentAiReportEntity report,
  ) {
    final theme = context.appTheme;
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.borderColor),
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: report.similarPlayerImageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const HorizontalSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'recentAiReport.similarPlayer'.tr(),
                style: theme.regular14.copyWith(
                  fontSize: 12.sp,
                  color: theme.grey,
                ),
              ),
              Text(
                report.similarPlayerName,
                style: theme.semiBold16.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: theme.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            report.similarPlayerClub,
            style: theme.medium14.copyWith(
              fontSize: 12.sp,
              color: theme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
