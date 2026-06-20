import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/di/di.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
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
                          state.fullWeeklyPlan.errorMessage ?? "Error loading plan",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomeViewModel>().doIntent(GetFullWeeklyPlanIntent());
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final fullWeeklyPlan = state.fullWeeklyPlan.data;
              if (fullWeeklyPlan == null || fullWeeklyPlan.isEmpty) {
                return const Center(child: Text("No data available"));
              }

              final List<DayPlan> days = fullWeeklyPlan.map((e) {
                int totalMinutes = e.sessions.fold(0, (sum, session) => sum + session.expectedDurationMinutes);
                int totalXp = e.sessions.fold(0, (sum, session) => sum + session.rewardXp);
                
                return DayPlan(
                  dayLabel: e.isToday ? "Today" : "Upcoming",
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, size: 24.sp, color: Colors.black87),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Weekly Plan',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
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
                  'Week$_weekIndex',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF999999),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _weekRange,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 20.sp, color: Colors.black54),
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
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool active = plan.isActive;

    return Container(
      decoration: BoxDecoration(
        color: active ? const Color(0xFF2E7D32) : Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: active
            ? null
            : Border.all(color: const Color(0xFFE8E8E8), width: 1),
        boxShadow: [
          BoxShadow(
            color: active
                ? const Color(0xFF2E7D32).withOpacity(0.25)
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
                                  ? Colors.white.withOpacity(0.75)
                                  : const Color(0xFF999999),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            plan.dayName,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: active ? Colors.white : Colors.black87,
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
                            ? Colors.white.withOpacity(0.15)
                            : const Color(0xFFF2F2F2),
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
                              color: active ? Colors.white : Colors.black87,
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
                        icon: Icons.format_list_bulleted,
                        label: '${plan.tasks} Sessions',
                        active: active,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Flexible(
                      child: _statChip(
                        icon: Icons.access_time_rounded,
                        label: '${plan.minutes} mins',
                        active: active,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.chevron_right,
                      size: 20.sp,
                      color: active ? Colors.white.withOpacity(0.8) : Colors.black45,
                    ),
                  ],
                ),
                if (active && plan.sessions.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  const Divider(color: Colors.white24),
                  SizedBox(height: 8.h),
                  ...plan.sessions.take(2).map((session) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      children: [
                        Icon(session.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked, 
                             size: 16.sp, 
                             color: session.isCompleted ? Colors.white : Colors.white60),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            session.title,
                            style: TextStyle(
                              color: Colors.white,
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
    required IconData icon,
    required String label,
    required bool active,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14.sp,
          color: active ? Colors.white.withOpacity(0.8) : const Color(0xFF888888),
        ),
        SizedBox(width: 6.w),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: active ? Colors.white.withOpacity(0.9) : const Color(0xFF666666),
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
    final Color color = active
        ? Colors.white.withOpacity(0.12)
        : const Color(0xFF2E7D32).withOpacity(0.15);
    final Color pentagons = active
        ? Colors.white.withOpacity(0.18)
        : const Color(0xFF2E7D32).withOpacity(0.25);

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
