class WeeklyPlanEntity {
  final int totalXp;
  final int totalSessionsCount;
  final List<WeeklyDayProgressEntity> weeklyProgress;

  WeeklyPlanEntity({
    required this.totalXp,
    required this.totalSessionsCount,
    required this.weeklyProgress,
  });
}

class WeeklyDayProgressEntity {
  final String dayName;
  final int xpEarned;

  WeeklyDayProgressEntity({
    required this.dayName,
    required this.xpEarned,
  });
}
