import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/di/di.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/home/domain/entity/full_weekly_plan_entity.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_state.dart';
import 'package:junior_football/feature/home/presentation/view_model/home_view_model.dart';

// ─── Data Model ───────────────────────────────────────────────────────────────

enum Difficulty { easy, medium, hard }

class DayPlan {
  final String dayLabel;
  final String dayName;
  final int tasks;
  final int minutes;
  final Difficulty difficulty;
  final bool isActive;
  final List<HomeSessionEntity> sessions;

  const DayPlan({
    required this.dayLabel,
    required this.dayName,
    required this.tasks,
    required this.minutes,
    required this.difficulty,
    required this.sessions,
    this.isActive = false,
  });
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class WeeklyPlanScreen extends StatefulWidget {
  const WeeklyPlanScreen({super.key});

  @override
  State<WeeklyPlanScreen> createState() => _WeeklyPlanScreenState();
}

class _WeeklyPlanScreenState extends State<WeeklyPlanScreen> {
  int _weekIndex = 12;

  String get _weekRange {
    const ranges = {
      11: '5Nov - 12Nov',
      12: '12Nov - 19Nov',
      13: '19Nov - 26Nov',
    };
    return ranges[_weekIndex] ?? '12Nov - 19Nov';
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt.get<HomeViewModel>()..doIntent(GetFullWeeklyPlanIntent()),
          child: BlocBuilder<HomeViewModel, HomeState>(
            builder: (context, state) {
              if (state.fullWeeklyPlan.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.fullWeeklyPlan.isError) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.fullWeeklyPlan.errorMessage ?? "weeklyPlan.errorLoading".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomeViewModel>().doIntent(GetFullWeeklyPlanIntent());
                          },
                          child: Text("weeklyPlan.retry".tr()),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final fullWeeklyPlan = state.fullWeeklyPlan.data;
              if (fullWeeklyPlan == null || fullWeeklyPlan.isEmpty) {
                return Center(child: Text("weeklyPlan.noData".tr()));
              }

              final List<DayPlan> days = fullWeeklyPlan.map((e) {
                int totalMinutes = e.sessions.fold(0, (sum, session) => sum + session.expectedDurationMinutes);
                int totalXp = e.sessions.fold(0, (sum, session) => sum + session.rewardXp);
                
                return DayPlan(
                  dayLabel: e.isToday ? "weeklyPlan.today".tr() : "weeklyPlan.upcoming".tr(),
                  dayName: e.dayName,
                  tasks: e.sessions.length,
                  minutes: totalMinutes,
                  difficulty: totalXp > 100 
                      ? Difficulty.hard 
                      : (totalXp > 50 ? Difficulty.medium : Difficulty.easy),
                  isActive: e.isToday,
                  sessions: e.sessions,
                );
              }).toList();

              return Column(
                children: [
                  _buildAppBar(context),
                  SizedBox(height: 12.h),
                  _buildWeekNavigator(),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                      itemCount: days.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) => _DayCard(plan: days[index]),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, size: 24.sp, color: theme.textColor),
          ),
          Expanded(
            child: Center(
              child: Text(
                'home.weeklyPlan'.tr(),
                style: theme.semiBold16.copyWith(
                  fontSize: 18.sp,
                  color: theme.textColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 24.sp),
        ],
      ),
    );
  }

  Widget _buildWeekNavigator() {
    final theme = context.appTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: theme.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navButton(Icons.chevron_left, () {
              setState(() => _weekIndex--);
            }),
            Column(
              children: [
                Text(
                  '${"weeklyPlan.week".tr()}$_weekIndex',
                  style: theme.regular14.copyWith(
                    fontSize: 12.sp,
                    color: theme.grey,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _weekRange,
                  style: theme.semiBold16.copyWith(
                    fontSize: 14.sp,
                    color: theme.textColor,
                  ),
                ),
              ],
            ),
            _navButton(Icons.chevron_right, () {
              setState(() => _weekIndex++);
            }),
          ],
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap) {
    final theme = context.appTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: theme.surfaceMuted,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 20.sp, color: theme.subTitle),
      ),
    );
  }
}

// ─── Day Card ─────────────────────────────────────────────────────────────────

class _DayCard extends StatelessWidget {
  final DayPlan plan;
  const _DayCard({required this.plan});

  Color get _difficultyColor {
    switch (plan.difficulty) {
      case Difficulty.easy:
        return const Color(0xFF4CAF50);
      case Difficulty.medium:
        return const Color(0xFFFFB300);
      case Difficulty.hard:
        return const Color(0xFFE53935);
    }
  }

  String get _difficultyLabel {
    switch (plan.difficulty) {
      case Difficulty.easy:
        return "weeklyPlan.easy".tr();
      case Difficulty.medium:
        return "weeklyPlan.medium".tr();
      case Difficulty.hard:
        return "weeklyPlan.hard".tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final bool active = plan.isActive;

    return Container(
      decoration: BoxDecoration(
        color: active ? theme.primary : theme.backgroundColor,
        borderRadius: BorderRadius.circular(18.r),
        border: active
            ? null
            : Border.all(color: theme.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: active
                ? theme.primary.withOpacity(0.25)
                : Colors.black.withOpacity(0.04),
            blurRadius: active ? 14 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          if (active)
            Positioned(
              right: -18.w,
              top: -18.h,
              child: _SoccerBallDecor(active: active),
            ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.dayLabel,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: active
                                  ? theme.secondary.withOpacity(0.75)
                                  : theme.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            plan.dayName,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: active ? theme.secondary : theme.textColor,
                              letterSpacing: -0.3,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: active
                            ? theme.secondary.withOpacity(0.15)
                            : theme.surfaceMuted,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: _difficultyColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            _difficultyLabel,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: active ? theme.secondary : theme.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Flexible(
                      child: _statChip(
                        context: context,
                        icon: Icons.format_list_bulleted,
                        label: '${plan.tasks} ${"weeklyPlan.sessions".tr()}',
                        active: active,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Flexible(
                      child: _statChip(
                        context: context,
                        icon: Icons.access_time_rounded,
                        label: '${plan.minutes} ${"weeklyPlan.mins".tr()}',
                        active: active,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.chevron_right,
                      size: 20.sp,
                      color: active
                          ? theme.secondary.withOpacity(0.8)
                          : theme.subTitle,
                    ),
                  ],
                ),
                if (active && plan.sessions.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  Divider(color: theme.secondary.withOpacity(0.24)),
                  SizedBox(height: 8.h),
                  ...plan.sessions.take(2).map((session) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      children: [
                        Icon(session.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked, 
                             size: 16.sp, 
                             color: session.isCompleted ? theme.secondary : theme.secondary.withOpacity(0.6)),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            session.title,
                            style: TextStyle(
                              color: theme.secondary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statChip({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool active,
  }) {
    final theme = context.appTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14.sp,
          color: active ? theme.secondary.withOpacity(0.8) : theme.grey,
        ),
        SizedBox(width: 6.w),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: active
                  ? theme.secondary.withOpacity(0.9)
                  : theme.subTitle,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ─── Soccer Ball Decoration ─────────────────────────────────────────

class _SoccerBallDecor extends StatelessWidget {
  final bool active;
  const _SoccerBallDecor({required this.active});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final Color color = active
        ? theme.secondary.withOpacity(0.12)
        : theme.primary.withOpacity(0.15);
    final Color pentagons = active
        ? theme.secondary.withOpacity(0.18)
        : theme.primary.withOpacity(0.25);

    return SizedBox(
      width: 90.w,
      height: 90.h,
      child: CustomPaint(
        painter: _SoccerBallPainter(bgColor: color, penColor: pentagons),
      ),
    );
  }
}

class _SoccerBallPainter extends CustomPainter {
  final Color bgColor;
  final Color penColor;

  _SoccerBallPainter({required this.bgColor, required this.penColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, Paint()..color = bgColor);

    final penPaint = Paint()
      ..color = penColor
      ..style = PaintingStyle.fill;

    _drawPentagon(canvas, center, 14, 0, penPaint);

    const count = 5;
    for (int i = 0; i < count; i++) {
      final angle = (i * 2 * math.pi / count) - 1.57;
      final dx = center.dx + 26 * math.cos(angle);
      final dy = center.dy + 26 * math.sin(angle);
      _drawPentagon(canvas, Offset(dx, dy), 11, angle, penPaint);
    }
  }

  void _drawPentagon(Canvas canvas, Offset center, double r, double rotation, Paint paint) {
    const sides = 6;
    final path = Path();
    for (int i = 0; i < sides; i++) {
      final angle = rotation + (i * 2 * math.pi / sides);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
