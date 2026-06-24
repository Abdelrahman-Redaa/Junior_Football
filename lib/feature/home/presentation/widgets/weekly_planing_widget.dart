import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/home/domain/entity/weekly_plan_entity.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_view_model.dart';

class WeeklyPlanCard extends StatelessWidget {
  const WeeklyPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        if (state.weeklyPlan.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.weeklyPlan.isError) {
          return Center(child: Text(state.weeklyPlan.errorMessage ?? "Error"));
        }
        final weeklyPlan = state.weeklyPlan.data;
        if (weeklyPlan == null) {
          return const SizedBox.shrink();
        }

        final double progress = (weeklyPlan.totalSessionsCount / 7).clamp(0.0, 1.0);
        final List<String> daysOrder = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'home.weeklyPlan'.tr(),
                    style: theme.semiBold24.copyWith(
                      fontSize: 20,
                      letterSpacing: -0.3,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.weeklyPlanView);
                    },
                    child: Text(
                      'home.viewMore'.tr(),
                      style: theme.regular14.copyWith(
                        fontSize: 13,
                        color: theme.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.surfaceMuted,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'home.weekProgress'.tr(),
                          style: theme.regular14.copyWith(
                            fontSize: 13,
                            color: theme.subTitle,
                          ),
                        ),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: theme.medium14.copyWith(
                            color: theme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: theme.progressTrack,
                        valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: daysOrder.map((dayName) {
                  final dayData = weeklyPlan.weeklyProgress.firstWhere(
                    (element) => element.dayName.toLowerCase().startsWith(dayName.toLowerCase().substring(0, 2)),
                    orElse: () => WeeklyDayProgressEntity(dayName: dayName, xpEarned: 0),
                  );

                  DayStatus status;
                  if (dayData.xpEarned > 0) {
                    status = DayStatus.completed;
                  } else {
                    status = DayStatus.upcoming;
                  }

                  return _DayItem(
                    label: dayName,
                    status: status,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum DayStatus { completed, current, upcoming }

class _DayItem extends StatelessWidget {
  final String label;
  final DayStatus status;

  const _DayItem({required this.label, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      children: [
        Text(
          label,
          style: theme.regular14.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: status == DayStatus.upcoming ? theme.neutral : theme.subTitle,
          ),
        ),
        const SizedBox(height: 6),
        _buildCircle(context),
      ],
    );
  }

  Widget _buildCircle(BuildContext context) {
    final theme = context.appTheme;
    switch (status) {
      case DayStatus.completed:
        return Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: theme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            color: theme.secondary,
            size: 20,
          ),
        );

      case DayStatus.current:
        return Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: theme.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: theme.primary.withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.play_arrow_rounded,
            color: theme.secondary,
            size: 22,
          ),
        );

      case DayStatus.upcoming:
        return Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: theme.progressTrack,
            shape: BoxShape.circle,
          ),
        );
    }
  }
}
