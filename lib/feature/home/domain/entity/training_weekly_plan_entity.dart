import 'training_dashboard_entity.dart';

class TrainingWeeklyPlanEntity {
  final String weekStartDate;
  final String weekEndDate;
  final int completedDays;
  final int totalDays;
  final double completionProgress;
  final int totalXpAvailable;
  final int totalXpEarned;
  final List<TrainingWeeklyDayEntity> days;

  const TrainingWeeklyPlanEntity({
    required this.weekStartDate,
    required this.weekEndDate,
    required this.completedDays,
    required this.totalDays,
    required this.completionProgress,
    required this.totalXpAvailable,
    required this.totalXpEarned,
    required this.days,
  });
}

class TrainingWeeklyDayEntity {
  final String planId;
  final String day;
  final String dayShort;
  final String date;
  final bool isToday;
  final bool isCompleted;
  final bool hasSession;
  final bool isRestDay;
  final int xpEarned;
  final TodaySessionEntity? session;

  const TrainingWeeklyDayEntity({
    required this.planId,
    required this.day,
    required this.dayShort,
    required this.date,
    required this.isToday,
    required this.isCompleted,
    required this.hasSession,
    required this.isRestDay,
    required this.xpEarned,
    required this.session,
  });
}
