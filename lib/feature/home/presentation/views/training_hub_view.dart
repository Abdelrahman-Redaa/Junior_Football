import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/core/routes/routes_name.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/home/domain/entity/training_dashboard_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_lesson_entity.dart';
import 'package:junior_football/feature/home/domain/entity/training_weekly_plan_entity.dart';
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
        ..doIntent(GetTrainingDailySessionIntent())
        ..doIntent(GetTrainingWeeklyPlanIntent())
        ..doIntent(GetTrainingRecommendationsIntent())
        ..doIntent(GetTrainingLessonsIntent()),
      child: const DefaultTabController(length: 5, child: _TrainingHubBody()),
    );
  }
}

class _TrainingHubBody extends StatelessWidget {
  const _TrainingHubBody();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Hub'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(52.h),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: theme.primary,
              labelColor: theme.primary,
              unselectedLabelColor: theme.neutral,
              tabs: const [
                Tab(text: 'Home'),
                Tab(text: 'Today'),
                Tab(text: 'Weekly'),
                Tab(text: 'Plan'),
                Tab(text: 'Recommended'),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<HomeViewModel, HomeState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async => _refresh(context),
            child: TabBarView(
              children: [
                _HubHomeTab(state: state),
                _TodaySessionTab(state: state),
                _WeeklyProgressTab(state: state),
                _WeeklyPlanTab(state: state),
                _RecommendationsTab(state: state),
              ],
            ),
          );
        },
      ),
    );
  }

  void _refresh(BuildContext context) {
    context.read<HomeViewModel>()
      ..doIntent(GetTrainingDashboardIntent())
      ..doIntent(GetTrainingDailySessionIntent())
      ..doIntent(GetTrainingWeeklyPlanIntent())
      ..doIntent(GetTrainingRecommendationsIntent())
      ..doIntent(GetTrainingLessonsIntent());
  }
}

class _HubHomeTab extends StatelessWidget {
  const _HubHomeTab({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final dashboard = state.trainingDashboard.data;
    return _TrainingScroll(
      isLoading: state.trainingDashboard.isLoading,
      error: state.trainingDashboard.errorMessage,
      children: [
        _HeroCard(dashboard: dashboard),
        SizedBox(height: 16.h),
        _MetricGrid(dashboard: dashboard),
        SizedBox(height: 18.h),
        _SectionHeader(
          title: 'Today session',
          action: 'Open',
          onTap: () => DefaultTabController.of(context).animateTo(1),
        ),
        SizedBox(height: 10.h),
        _DailySessionCard(
          session: state.trainingDailySession.data ?? dashboard?.todaySession,
        ),
        SizedBox(height: 18.h),
        _SectionHeader(
          title: 'Weekly progress',
          action: 'Details',
          onTap: () => DefaultTabController.of(context).animateTo(2),
        ),
        SizedBox(height: 10.h),
        _WeeklyBars(activity: dashboard?.weeklyActivity ?? const []),
      ],
    );
  }
}

class _TodaySessionTab extends StatelessWidget {
  const _TodaySessionTab({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final session =
        state.trainingDailySession.data ??
        state.trainingDashboard.data?.todaySession;
    return _TrainingScroll(
      isLoading: state.trainingDailySession.isLoading,
      error: state.trainingDailySession.errorMessage,
      children: [
        _DailySessionCard(session: session, expanded: true),
        SizedBox(height: 16.h),
        _InfoPanel(
          icon: Icons.local_fire_department_outlined,
          title: 'Coach note',
          body: session?.coachNote.isNotEmpty == true
              ? session!.coachNote
              : 'Keep your touches clean and finish the session with high focus.',
        ),
        SizedBox(height: 16.h),
        _SessionStats(session: session),
      ],
    );
  }
}

class _WeeklyProgressTab extends StatelessWidget {
  const _WeeklyProgressTab({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final dashboard = state.trainingDashboard.data;
    return _TrainingScroll(
      isLoading: state.trainingDashboard.isLoading,
      error: state.trainingDashboard.errorMessage,
      children: [
        _ProgressRingCard(dashboard: dashboard),
        SizedBox(height: 16.h),
        _WeeklyBars(activity: dashboard?.weeklyActivity ?? const []),
        SizedBox(height: 16.h),
        _MetricGrid(dashboard: dashboard),
      ],
    );
  }
}

class _WeeklyPlanTab extends StatelessWidget {
  const _WeeklyPlanTab({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final plan = state.trainingWeeklyPlan.data;
    return _TrainingScroll(
      isLoading: state.trainingWeeklyPlan.isLoading,
      error: state.trainingWeeklyPlan.errorMessage,
      children: [
        _WeeklyPlanSummary(plan: plan),
        SizedBox(height: 16.h),
        ...(plan?.days ?? const <TrainingWeeklyDayEntity>[]).map(
          (day) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _WeeklyDayCard(day: day),
          ),
        ),
        if ((plan?.days ?? const []).isEmpty) const _EmptyPanel(),
      ],
    );
  }
}

class _RecommendationsTab extends StatelessWidget {
  const _RecommendationsTab({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return _TrainingScroll(
      isLoading:
          state.trainingRecommendations.isLoading ||
          state.speedLessons.isLoading ||
          state.shootingLessons.isLoading ||
          state.passingLessons.isLoading,
      error:
          state.trainingRecommendations.errorMessage ??
          state.speedLessons.errorMessage ??
          state.shootingLessons.errorMessage ??
          state.passingLessons.errorMessage,
      children: [
        _QuickRecommendations(
          recommendations:
              state.trainingRecommendations.data ??
              state.trainingDashboard.data?.quickRecommendations ??
              const [],
        ),
        SizedBox(height: 18.h),
        _LessonSection(
          title: 'Speed',
          icon: Icons.speed_outlined,
          lessons: state.speedLessons.data,
          fallbackVideo: TrainingHubView.dailyVideo,
        ),
        SizedBox(height: 14.h),
        _LessonSection(
          title: 'Shooting',
          icon: Icons.sports_soccer_outlined,
          lessons: state.shootingLessons.data,
          fallbackVideo: TrainingHubView.shootingVideo,
        ),
        SizedBox(height: 14.h),
        _LessonSection(
          title: 'Passing',
          icon: Icons.swap_calls_outlined,
          lessons: state.passingLessons.data,
          fallbackVideo: TrainingHubView.passingVideo,
        ),
      ],
    );
  }
}

class _TrainingScroll extends StatelessWidget {
  const _TrainingScroll({
    required this.children,
    this.isLoading = false,
    this.error,
  });

  final List<Widget> children;
  final bool isLoading;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 28.h),
      children: [
        if (isLoading) const LinearProgressIndicator(),
        if (isLoading) SizedBox(height: 14.h),
        if (error != null && error!.isNotEmpty) ...[
          _ErrorPanel(message: error!),
          SizedBox(height: 14.h),
        ],
        ...children,
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.dashboard});

  final TrainingDashboardEntity? dashboard;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi ${dashboard?.userName.isNotEmpty == true ? dashboard!.userName : 'player'}',
            style: theme.semiBold24.copyWith(color: Colors.white),
          ),
          SizedBox(height: 4.h),
          Text(
            'Level: ${dashboard?.userLevel.isNotEmpty == true ? dashboard!.userLevel : 'Beginner'}',
            style: theme.regular14.copyWith(color: Colors.white70),
          ),
          SizedBox(height: 16.h),
          LinearProgressIndicator(
            value: _safeProgress(
              (dashboard?.xpProgress ?? 0).toDouble(),
              (dashboard?.nextLevelXp ?? 100).toDouble(),
            ),
            minHeight: 8.h,
            backgroundColor: Colors.white24,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          SizedBox(height: 8.h),
          Text(
            '${dashboard?.xpProgress ?? 0}/${dashboard?.nextLevelXp ?? 0} XP',
            style: theme.medium14.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.dashboard});

  final TrainingDashboardEntity? dashboard;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MetricCard(
            label: 'Sessions',
            value: '${dashboard?.totalCompletedSessions ?? 0}',
            icon: Icons.check_circle_outline,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _MetricCard(
            label: 'Minutes',
            value: '${dashboard?.totalTrainingMinutes ?? 0}',
            icon: Icons.timer_outlined,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _MetricCard(
            label: 'Streak',
            value: '${dashboard?.currentStreak ?? 0}',
            icon: Icons.bolt_outlined,
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.primary, size: 22.r),
          SizedBox(height: 8.h),
          Text(value, style: theme.semiBold24),
          Text(label, style: theme.regular14.copyWith(color: theme.neutral)),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.action, this.onTap});

  final String title;
  final String? action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      children: [
        Expanded(child: Text(title, style: theme.semiBold24)),
        if (action != null) TextButton(onPressed: onTap, child: Text(action!)),
      ],
    );
  }
}

class _DailySessionCard extends StatelessWidget {
  const _DailySessionCard({required this.session, this.expanded = false});

  final TodaySessionEntity? session;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final title = session?.title.isNotEmpty == true
        ? session!.title
        : 'Daily session';
    final description = session?.description.isNotEmpty == true
        ? session!.description
        : 'Your session will appear here when it is ready.';
    return _Panel(
      padding: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: session == null
            ? null
            : () => _openSession(context, session!, TrainingHubView.dailyVideo),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Thumb(
              imageUrl: session?.thumbnailUrl ?? '',
              height: expanded ? 170.h : 118.h,
              icon: Icons.play_circle_outline,
            ),
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(title, style: theme.semiBold16)),
                      _Chip(label: session?.difficulty ?? 'Ready'),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    description,
                    maxLines: expanded ? 4 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.regular14.copyWith(color: theme.neutral),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _Chip(label: '${session?.durationMinutes ?? 0} min'),
                      _Chip(label: '${session?.xpReward ?? 0} XP'),
                      _Chip(label: '${session?.drillsCount ?? 0} drills'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionStats extends StatelessWidget {
  const _SessionStats({required this.session});

  final TodaySessionEntity? session;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoPanel(
          icon: Icons.fitness_center_outlined,
          title: 'Session type',
          body: session?.sessionType.isNotEmpty == true
              ? session!.sessionType
              : 'Training',
        ),
        SizedBox(height: 12.h),
        _InfoPanel(
          icon: Icons.local_fire_department_outlined,
          title: 'Calories',
          body: '${session?.estimatedCalories ?? 0} kcal',
        ),
      ],
    );
  }
}

class _ProgressRingCard extends StatelessWidget {
  const _ProgressRingCard({required this.dashboard});

  final TrainingDashboardEntity? dashboard;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final progress = ((dashboard?.weeklyProgress ?? 0) / 100).clamp(0.0, 1.0);
    return _Panel(
      child: Row(
        children: [
          SizedBox(
            width: 86.r,
            height: 86.r,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 9,
                  backgroundColor: theme.progressTrack,
                  color: theme.primary,
                ),
                Text('${(progress * 100).round()}%', style: theme.semiBold16),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weekly progress', style: theme.semiBold24),
                SizedBox(height: 6.h),
                Text(
                  '${dashboard?.weeklySessionsCompleted ?? 0}/${dashboard?.weeklySessionsTotal ?? 0} sessions completed',
                  style: theme.regular14.copyWith(color: theme.neutral),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyBars extends StatelessWidget {
  const _WeeklyBars({required this.activity});

  final List<WeeklyActivityEntity> activity;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final values = activity.isEmpty ? const <WeeklyActivityEntity>[] : activity;
    final maxXp = values.fold<int>(1, (max, item) {
      return item.xpEarned > max ? item.xpEarned : max;
    });
    return _Panel(
      child: SizedBox(
        height: 150.h,
        child: values.isEmpty
            ? const Center(child: Text('No weekly activity yet'))
            : Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: values
                    .map(
                      (item) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: FractionallySizedBox(
                                    heightFactor: (item.xpEarned / maxXp).clamp(
                                      0.08,
                                      1.0,
                                    ),
                                    child: Container(
                                      width: 18.w,
                                      decoration: BoxDecoration(
                                        color: theme.primary,
                                        borderRadius: BorderRadius.circular(
                                          18.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                item.dayName.length > 3
                                    ? item.dayName.substring(0, 3)
                                    : item.dayName,
                                style: theme.regular14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}

class _WeeklyPlanSummary extends StatelessWidget {
  const _WeeklyPlanSummary({required this.plan});

  final TrainingWeeklyPlanEntity? plan;

  @override
  Widget build(BuildContext context) {
    final progress = ((plan?.completionProgress ?? 0) / 100).clamp(0.0, 1.0);
    final theme = context.appTheme;
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly plan', style: theme.semiBold24),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: progress,
            minHeight: 8.h,
            borderRadius: BorderRadius.circular(20.r),
            backgroundColor: theme.progressTrack,
            color: theme.primary,
          ),
          SizedBox(height: 10.h),
          Text(
            '${plan?.completedDays ?? 0}/${plan?.totalDays ?? 0} days complete - ${plan?.totalXpEarned ?? 0}/${plan?.totalXpAvailable ?? 0} XP',
            style: theme.regular14.copyWith(color: theme.neutral),
          ),
        ],
      ),
    );
  }
}

class _WeeklyDayCard extends StatelessWidget {
  const _WeeklyDayCard({required this.day});

  final TrainingWeeklyDayEntity day;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final session = day.session;
    return _Panel(
      child: InkWell(
        onTap: session == null
            ? null
            : () => _openSession(context, session, TrainingHubView.dailyVideo),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: day.isToday
                  ? theme.primary
                  : theme.accentSurface,
              child: Text(
                day.dayShort.isNotEmpty ? day.dayShort : day.day.take(2),
                style: theme.medium14.copyWith(
                  color: day.isToday ? Colors.white : theme.primary,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(day.day, style: theme.semiBold16),
                  SizedBox(height: 4.h),
                  Text(
                    day.isRestDay
                        ? 'Rest day'
                        : session?.title ?? 'No session assigned',
                    style: theme.regular14.copyWith(color: theme.neutral),
                  ),
                ],
              ),
            ),
            _Chip(label: day.isCompleted ? 'Done' : '${day.xpEarned} XP'),
          ],
        ),
      ),
    );
  }
}

class _QuickRecommendations extends StatelessWidget {
  const _QuickRecommendations({required this.recommendations});

  final List<QuickRecommendationEntity> recommendations;

  @override
  Widget build(BuildContext context) {
    if (recommendations.isEmpty) return const SizedBox.shrink();
    final theme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Coach recommendations', style: theme.semiBold24),
        SizedBox(height: 10.h),
        ...recommendations.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: _Panel(
              child: Row(
                children: [
                  Icon(Icons.tips_and_updates_outlined, color: theme.primary),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: theme.semiBold16),
                        SizedBox(height: 3.h),
                        Text(
                          item.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.regular14.copyWith(color: theme.neutral),
                        ),
                      ],
                    ),
                  ),
                  if (item.xpBonus > 0) _Chip(label: '+${item.xpBonus} XP'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LessonSection extends StatelessWidget {
  const _LessonSection({
    required this.title,
    required this.icon,
    required this.lessons,
    required this.fallbackVideo,
  });

  final String title;
  final IconData icon;
  final LessonsListEntity? lessons;
  final String fallbackVideo;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final list = lessons?.lessons ?? const <LessonEntity>[];
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.primary),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  lessons?.title.isNotEmpty == true ? lessons!.title : title,
                  style: theme.semiBold24,
                ),
              ),
              _Chip(
                label:
                    '${lessons?.completedLessons ?? 0}/${lessons?.totalLessons ?? list.length}',
              ),
            ],
          ),
          if (lessons?.description.isNotEmpty == true) ...[
            SizedBox(height: 8.h),
            Text(
              lessons!.description,
              style: theme.regular14.copyWith(color: theme.neutral),
            ),
          ],
          SizedBox(height: 12.h),
          if (list.isEmpty)
            _EmptyPanel(message: 'No $title lessons yet')
          else
            ...list.map(
              (lesson) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _LessonCard(
                  lesson: lesson,
                  fallbackVideo: fallbackVideo,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  const _LessonCard({required this.lesson, required this.fallbackVideo});

  final LessonEntity lesson;
  final String fallbackVideo;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final video = lesson.videoUrl.isNotEmpty ? lesson.videoUrl : fallbackVideo;
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: lesson.isLocked
          ? null
          : () => Navigator.pushNamed(
              context,
              AppRoutes.sessionView,
              arguments: TrainingVideoArgs(
                title: lesson.title,
                videoUrl: video,
                description: lesson.description,
                duration: '${lesson.durationMinutes} min',
                difficulty: lesson.difficulty,
                xp: '${lesson.xpReward} XP',
                coachNote: lesson.coachNote,
                instructions: lesson.drills
                    .map(
                      (e) =>
                          e.instructions.isNotEmpty ? e.instructions : e.title,
                    )
                    .where((e) => e.isNotEmpty)
                    .toList(),
              ),
            ),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: theme.surfaceMuted,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            _Thumb(
              imageUrl: lesson.thumbnailUrl,
              height: 70.h,
              width: 86.w,
              icon: lesson.isLocked ? Icons.lock_outline : Icons.play_arrow,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lesson.title, style: theme.semiBold16),
                  SizedBox(height: 4.h),
                  Text(
                    lesson.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.regular14.copyWith(color: theme.neutral),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 6.w,
                    children: [
                      _Chip(label: '${lesson.durationMinutes} min'),
                      _Chip(label: lesson.difficulty),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.borderColor),
      ),
      child: child,
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: theme.accentSurface,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Text(
        label.isNotEmpty ? label : '-',
        style: theme.medium14.copyWith(color: theme.primary, fontSize: 11.sp),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({
    required this.imageUrl,
    required this.height,
    this.width,
    required this.icon,
  });

  final String imageUrl;
  final double height;
  final double? width;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        height: height,
        width: width ?? double.infinity,
        color: theme.accentSurface,
        child: imageUrl.isEmpty
            ? Icon(icon, color: theme.primary, size: 30.r)
            : Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(icon, color: theme.primary, size: 30.r),
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withValues(alpha: 0.45),
                      child: Icon(icon, color: Colors.white),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return _Panel(
      child: Row(
        children: [
          Icon(icon, color: theme.primary),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.semiBold16),
                SizedBox(height: 4.h),
                Text(
                  body,
                  style: theme.regular14.copyWith(color: theme.neutral),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorPanel extends StatelessWidget {
  const _ErrorPanel({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.red.withValues(alpha: 0.25)),
      ),
      child: Text(message, style: theme.regular14.copyWith(color: theme.red)),
    );
  }
}

class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel({this.message = 'No data yet'});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: theme.surfaceMuted,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Text(
        message,
        style: theme.regular14.copyWith(color: theme.neutral),
      ),
    );
  }
}

void _openSession(
  BuildContext context,
  TodaySessionEntity session,
  String fallbackVideo,
) {
  Navigator.pushNamed(
    context,
    AppRoutes.sessionView,
    arguments: TrainingVideoArgs(
      title: session.title,
      videoUrl: _extractFirstVideo(session.drills) ?? fallbackVideo,
      description: session.description,
      duration: '${session.durationMinutes} min',
      difficulty: session.difficulty,
      xp: '${session.xpReward} XP',
      coachNote: session.coachNote,
      instructions: _extractInstructions(session.drills),
    ),
  );
}

String? _extractFirstVideo(List<dynamic> drills) {
  for (final item in drills) {
    if (item is Map && (item['videoUrl']?.toString().isNotEmpty ?? false)) {
      return item['videoUrl'].toString();
    }
  }
  return null;
}

List<String> _extractInstructions(List<dynamic> drills) {
  final instructions = <String>[];
  for (final item in drills) {
    if (item is Map) {
      final value =
          item['instructions'] ?? item['title'] ?? item['description'];
      if (value != null && value.toString().isNotEmpty) {
        instructions.add(value.toString());
      }
    }
  }
  return instructions;
}

double _safeProgress(double value, double total) {
  if (total <= 0) return 0;
  return (value / total).clamp(0.0, 1.0);
}

extension _ShortString on String {
  String take(int length) {
    if (isEmpty) return '';
    return substring(0, this.length < length ? this.length : length);
  }
}
