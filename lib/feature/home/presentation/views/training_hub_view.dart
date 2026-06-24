import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/home/domain/entity/full_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_dashboard_entity.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_view_model.dart';
import 'package:junior_football/feature/session_training/presentation/views/session_view.dart';

class TrainingHubView extends StatelessWidget {
  const TrainingHubView({super.key});

  static const String shootingVideo =
      'https://footballfc.runasp.net/uploads/videos/21db6443-5d9c-4b6b-bf44-20e1074237fe.mp4';
  static const String passingVideo =
      'https://footballfc.runasp.net/uploads/videos/0a96d26c-169b-4d50-be6a-796601a8cac5.mp4';
  static const String dailyVideo =
      'https://footballfc.runasp.net/uploads/videos/15003242-488c-47de-a470-a607a7a45971.mp4';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<HomeViewModel>()
        ..doIntent(GetTrainingDashboardIntent())
        ..doIntent(GetFullWeeklyPlanIntent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Training Hub')),
        body: BlocBuilder<HomeViewModel, HomeState>(
          builder: (context, state) {
            if (state.trainingDashboard.isLoading &&
                state.fullWeeklyPlan.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final dashboard = state.trainingDashboard.data;
            final plans = state.fullWeeklyPlan.data ?? [];
            final todaySessions = _todaySessions(plans);

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeViewModel>()
                  ..doIntent(GetTrainingDashboardIntent())
                  ..doIntent(GetFullWeeklyPlanIntent());
              },
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                children: [
                  _HeroPanel(dashboard: dashboard),
                  SizedBox(height: 18.h),
                  _WeeklyProgressCard(dashboard: dashboard),
                  SizedBox(height: 18.h),
                  Text('Lessons', style: context.appTheme.semiBold24),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: _LessonCard(
                          title: 'Shooting lesson',
                          subtitle: 'Finishing and accuracy',
                          icon: SVGAssets.football,
                          onTap: () => _openVideo(
                            context,
                            title: 'Shooting lesson',
                            videoUrl: shootingVideo,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _LessonCard(
                          title: 'Passing lesson',
                          subtitle: 'Control and delivery',
                          icon: SVGAssets.passingLesson,
                          onTap: () => _openVideo(
                            context,
                            title: 'Passing lesson',
                            videoUrl: passingVideo,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Daily Session', style: context.appTheme.semiBold24),
                      if (state.fullWeeklyPlan.isLoading)
                        SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  if (state.trainingDashboard.isError &&
                      state.fullWeeklyPlan.isError)
                    _ErrorPanel(
                      message:
                          state.trainingDashboard.errorMessage ??
                          state.fullWeeklyPlan.errorMessage ??
                          'Error loading training data',
                    )
                  else if (todaySessions.isNotEmpty)
                    ...todaySessions.map(
                      (session) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _DailySessionCard(
                          session: session,
                          onTap: () => _openVideo(
                            context,
                            title: session.title,
                            videoUrl:
                                session.drills.isNotEmpty &&
                                    session.drills.first.videoUrl.isNotEmpty
                                ? session.drills.first.videoUrl
                                : dailyVideo,
                          ),
                        ),
                      ),
                    )
                  else if (dashboard?.todaySession != null)
                    _TodaySessionCard(
                      session: dashboard!.todaySession!,
                      onTap: () => _openVideo(
                        context,
                        title: dashboard.todaySession!.title,
                        videoUrl: dailyVideo,
                      ),
                    )
                  else
                    const _EmptyPanel(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<HomeSessionEntity> _todaySessions(List<FullWeeklyPlanEntity> plans) {
    for (final day in plans) {
      if (day.isToday) return day.sessions;
    }
    return plans.isNotEmpty ? plans.first.sessions : [];
  }

  void _openVideo(
    BuildContext context, {
    required String title,
    required String videoUrl,
  }) {
    Navigator.pushNamed(
      context,
      AppRoutes.sessionView,
      arguments: TrainingVideoArgs(title: title, videoUrl: videoUrl),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.dashboard});

  final TrainingDashboardEntity? dashboard;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final completed = dashboard?.totalCompletedSessions ?? 0;
    final minutes = dashboard?.totalTrainingMinutes ?? 0;
    final streak = dashboard?.currentStreak ?? 0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Keep improving',
            style: theme.semiBold24.copyWith(color: Colors.white),
          ),
          SizedBox(height: 4.h),
          Text(
            dashboard?.todaySession?.coachNote.isNotEmpty == true
                ? dashboard!.todaySession!.coachNote
                : 'Build your weekly rhythm and finish today strong.',
            style: theme.regular14.copyWith(color: Colors.white70),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _HeroMetric(label: 'Sessions', value: '$completed'),
              SizedBox(width: 10.w),
              _HeroMetric(label: 'Minutes', value: '$minutes'),
              SizedBox(width: 10.w),
              _HeroMetric(label: 'Streak', value: '$streak'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.13),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(color: Colors.white70, fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyProgressCard extends StatelessWidget {
  const _WeeklyProgressCard({required this.dashboard});

  final TrainingDashboardEntity? dashboard;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final completed = dashboard?.weeklySessionsCompleted ?? 0;
    final total = dashboard?.weeklySessionsTotal ?? 0;
    final progress = total == 0 ? 0.0 : (completed / total).clamp(0.0, 1.0);
    final activity = dashboard?.weeklyActivity ?? [];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: theme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Weekly Progress', style: theme.semiBold16),
              const Spacer(),
              Text(
                '$completed/$total',
                style: theme.medium14.copyWith(color: theme.primary),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(99.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10.h,
              backgroundColor: theme.progressTrack,
              valueColor: AlwaysStoppedAnimation(theme.primary),
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final label = _dayLabel(index);
              final xp = _xpForDay(activity, label);
              return _DayBubble(label: label, active: xp > 0);
            }),
          ),
        ],
      ),
    );
  }

  String _dayLabel(int index) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[index];
  }

  int _xpForDay(List<WeeklyActivityEntity> activity, String label) {
    for (final day in activity) {
      if (day.dayName.toLowerCase().startsWith(
        label.substring(0, 2).toLowerCase(),
      )) {
        return day.xpEarned;
      }
    }
    return 0;
  }
}

class _DayBubble extends StatelessWidget {
  const _DayBubble({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final color = theme.primary;
    return Column(
      children: [
        Text(
          label,
          style: theme.regular14.copyWith(fontSize: 11.sp, color: theme.subTitle),
        ),
        SizedBox(height: 6.h),
        Container(
          width: 26.r,
          height: 26.r,
          decoration: BoxDecoration(
            color: active ? color : theme.progressTrack,
            shape: BoxShape.circle,
          ),
          child: Icon(
            active ? Icons.check : Icons.circle,
            size: active ? 15.r : 7.r,
            color: active ? theme.secondary : theme.neutral,
          ),
        ),
      ],
    );
  }
}

class _LessonCard extends StatelessWidget {
  const _LessonCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: theme.accentSurface,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38.r,
              height: 38.r,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: theme.accentSurfaceStrong,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.semiBold16,
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.regular14.copyWith(
                color: theme.subTitle,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailySessionCard extends StatelessWidget {
  const _DailySessionCard({required this.session, required this.onTap});

  final HomeSessionEntity session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _SessionShell(
      title: session.title,
      subtitle: session.description,
      duration: '${session.expectedDurationMinutes} min',
      meta: '${session.drills.length} drills',
      done: session.isCompleted,
      onTap: onTap,
    );
  }
}

class _TodaySessionCard extends StatelessWidget {
  const _TodaySessionCard({required this.session, required this.onTap});

  final TodaySessionEntity session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _SessionShell(
      title: session.title,
      subtitle: session.description,
      duration: '${session.durationMinutes} min',
      meta: '${session.drillsCount} drills',
      done: session.status.toLowerCase() == 'completed',
      onTap: onTap,
    );
  }
}

class _SessionShell extends StatelessWidget {
  const _SessionShell({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.meta,
    required this.done,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String duration;
  final String meta;
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: theme.borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: done ? theme.primary : theme.accentSurface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                done ? Icons.check : Icons.play_arrow_rounded,
                color: done ? theme.secondary : theme.primary,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.semiBold16,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.regular14.copyWith(
                      color: theme.subTitle,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 14.r, color: theme.primary),
                      SizedBox(width: 4.w),
                      Text(duration, style: theme.medium14),
                      SizedBox(width: 12.w),
                      Icon(
                        Icons.sports_soccer,
                        size: 14.r,
                        color: theme.primary,
                      ),
                      SizedBox(width: 4.w),
                      Text(meta, style: theme.medium14),
                    ],
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

class _ErrorPanel extends StatelessWidget {
  const _ErrorPanel({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(message, style: const TextStyle(color: Colors.red)),
    );
  }
}

class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.borderColor),
      ),
      child: Text('home.noSession'.tr(), style: theme.regular16),
    );
  }
}
