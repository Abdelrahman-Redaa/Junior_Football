import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utilities/theme_extension.dart';

class AiRecommendationView extends StatelessWidget {
  const AiRecommendationView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String>? recommendations =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final theme = context.appTheme;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          "AI Recommendations",
          style: theme.semiBold24.copyWith(fontSize: 20.sp, color: theme.textColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.textColor, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: recommendations == null || recommendations.isEmpty
          ? _buildEmptyState(context)
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              itemCount: recommendations.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                String key = recommendations.keys.elementAt(index);
                String value = recommendations[key]!;
                return _buildRecommendationCard(context, key, value);
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics_outlined, size: 64.sp, color: theme.grey),
          SizedBox(height: 16.h),
          Text(
            "No recommendations available",
            style: theme.medium14.copyWith(color: theme.subTitle, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(
      BuildContext context, String title, String content) {
    final theme = context.appTheme;

    // Contextual styling based on the section title keywords
    IconData iconData = Icons.auto_awesome;
    Color accentColor = theme.primary;

    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('strength')) {
      iconData = Icons.star_rounded;
      accentColor = const Color(0xff28A745); // Using a standard success green or theme.primary
    } else if (lowerTitle.contains('weakness')) {
      iconData = Icons.trending_down_rounded;
      accentColor = theme.red;
    } else if (lowerTitle.contains('tip') || lowerTitle.contains('improvement')) {
      iconData = Icons.tips_and_updates_rounded;
      accentColor = theme.yellow;
    } else if (lowerTitle.contains('overview')) {
      iconData = Icons.assignment_ind_rounded;
      accentColor = theme.primary;
    } else if (lowerTitle.contains('conclusion')) {
      iconData = Icons.verified_rounded;
      accentColor = theme.secondary;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: theme.borderColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.08),
                border: Border(
                  bottom: BorderSide(
                    color: accentColor.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(iconData, color: accentColor, size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      title.trim(),
                      style: theme.semiBold24.copyWith(
                        fontSize: 17.sp,
                        color: accentColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
              child: Text(
                content.trim(),
                style: theme.medium14.copyWith(
                  fontSize: 15.sp,
                  color: theme.textColor.withValues(alpha: 0.85),
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
