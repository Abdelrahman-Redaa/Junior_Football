class FullWeeklyPlanEntity {
  final String dayName;
  final bool isToday;
  final List<HomeSessionEntity> sessions;

  FullWeeklyPlanEntity({
    required this.dayName,
    required this.isToday,
    required this.sessions,
  });
}

class HomeSessionEntity {
  final String id;
  final String title;
  final String description;
  final int expectedDurationMinutes;
  final int rewardXp;
  final String thumbnailUrl;
  final bool isCompleted;
  final List<DrillEntity> drills;

  HomeSessionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.expectedDurationMinutes,
    required this.rewardXp,
    required this.thumbnailUrl,
    required this.isCompleted,
    required this.drills,
  });
}

class DrillEntity {
  final String id;
  final String title;
  final String description;
  final int repetitions;
  final String videoUrl;
  final int orderIndex;

  DrillEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.repetitions,
    required this.videoUrl,
    required this.orderIndex,
  });
}
