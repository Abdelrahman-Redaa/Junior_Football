class TrainingDashboardEntity {
  final String userName;
  final String userLevel;
  final String userAvatarUrl;
  final int totalXp;
  final int nextLevelXp;
  final int xpProgress;
  final int weeklySessionsCompleted;
  final int weeklySessionsTotal;
  final int weeklyProgress;
  final int totalCompletedSessions;
  final int totalTrainingMinutes;
  final int currentStreak;
  final TodaySessionEntity? todaySession;
  final List<SummaryCardEntity> summaryCards;
  final List<WeeklyActivityEntity> weeklyActivity;
  final List<dynamic> recentBadges;
  final List<QuickRecommendationEntity> quickRecommendations;

  TrainingDashboardEntity({
    required this.userName,
    required this.userLevel,
    required this.userAvatarUrl,
    required this.totalXp,
    required this.nextLevelXp,
    required this.xpProgress,
    required this.weeklySessionsCompleted,
    required this.weeklySessionsTotal,
    required this.weeklyProgress,
    required this.totalCompletedSessions,
    required this.totalTrainingMinutes,
    required this.currentStreak,
    required this.todaySession,
    required this.summaryCards,
    required this.weeklyActivity,
    required this.recentBadges,
    required this.quickRecommendations,
  });
}

class TodaySessionEntity {
  final String sessionId;
  final String title;
  final String description;
  final int durationMinutes;
  final int xpReward;
  final String difficulty;
  final String status;
  final String thumbnailUrl;
  final String coachNote;
  final int estimatedCalories;
  final int drillsCount;
  final String sessionType;
  final List<String> tags;
  final List<dynamic> drills;

  TodaySessionEntity({
    required this.sessionId,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.xpReward,
    required this.difficulty,
    required this.status,
    required this.thumbnailUrl,
    required this.coachNote,
    required this.estimatedCalories,
    required this.drillsCount,
    required this.sessionType,
    required this.tags,
    required this.drills,
  });
}

class SummaryCardEntity {
  final String title;
  final String value;
  final String subtitle;
  final String iconName;
  final String color;

  SummaryCardEntity({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.iconName,
    required this.color,
  });
}

class WeeklyActivityEntity {
  final String dayName;
  final int xpEarned;

  WeeklyActivityEntity({
    required this.dayName,
    required this.xpEarned,
  });
}

class QuickRecommendationEntity {
  final String id;
  final String title;
  final String description;
  final String type;
  final String priority;
  final dynamic linkedSessionId;
  final String linkedSessionTitle;
  final String linkedLessonId;
  final String iconName;
  final String color;
  final int xpBonus;
  final String actionLabel;

  QuickRecommendationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    required this.linkedSessionId,
    required this.linkedSessionTitle,
    required this.linkedLessonId,
    required this.iconName,
    required this.color,
    required this.xpBonus,
    required this.actionLabel,
  });
}
