import 'package:json_annotation/json_annotation.dart';

part 'training_dashboard.g.dart';

@JsonSerializable()
class TrainingDashboard {
  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "userLevel")
  final String? userLevel;
  @JsonKey(name: "userAvatarUrl")
  final String? userAvatarUrl;
  @JsonKey(name: "totalXp")
  final int? totalXp;
  @JsonKey(name: "nextLevelXp")
  final int? nextLevelXp;
  @JsonKey(name: "xpProgress")
  final int? xpProgress;
  @JsonKey(name: "weeklySessionsCompleted")
  final int? weeklySessionsCompleted;
  @JsonKey(name: "weeklySessionsTotal")
  final int? weeklySessionsTotal;
  @JsonKey(name: "weeklyProgress")
  final int? weeklyProgress;
  @JsonKey(name: "totalCompletedSessions")
  final int? totalCompletedSessions;
  @JsonKey(name: "totalTrainingMinutes")
  final int? totalTrainingMinutes;
  @JsonKey(name: "currentStreak")
  final int? currentStreak;
  @JsonKey(name: "todaySession")
  final TodaySession? todaySession;
  @JsonKey(name: "summaryCards")
  final List<SummaryCards>? summaryCards;
  @JsonKey(name: "weeklyActivity")
  final List<WeeklyActivity>? weeklyActivity;
  @JsonKey(name: "recentBadges")
  final List<dynamic>? recentBadges;
  @JsonKey(name: "quickRecommendations")
  final List<QuickRecommendations>? quickRecommendations;

  TrainingDashboard ({
    this.userName,
    this.userLevel,
    this.userAvatarUrl,
    this.totalXp,
    this.nextLevelXp,
    this.xpProgress,
    this.weeklySessionsCompleted,
    this.weeklySessionsTotal,
    this.weeklyProgress,
    this.totalCompletedSessions,
    this.totalTrainingMinutes,
    this.currentStreak,
    this.todaySession,
    this.summaryCards,
    this.weeklyActivity,
    this.recentBadges,
    this.quickRecommendations,
  });

  factory TrainingDashboard.fromJson(Map<String, dynamic> json) {
    return _$TrainingDashboardFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TrainingDashboardToJson(this);
  }
}

@JsonSerializable()
class TodaySession {
  @JsonKey(name: "sessionId")
  final String? sessionId;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "durationMinutes")
  final int? durationMinutes;
  @JsonKey(name: "xpReward")
  final int? xpReward;
  @JsonKey(name: "difficulty")
  final String? difficulty;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "thumbnailUrl")
  final String? thumbnailUrl;
  @JsonKey(name: "coachNote")
  final String? coachNote;
  @JsonKey(name: "estimatedCalories")
  final int? estimatedCalories;
  @JsonKey(name: "drillsCount")
  final int? drillsCount;
  @JsonKey(name: "sessionType")
  final String? sessionType;
  @JsonKey(name: "tags")
  final List<String>? tags;
  @JsonKey(name: "drills")
  final List<dynamic>? drills;

  TodaySession ({
    this.sessionId,
    this.title,
    this.description,
    this.durationMinutes,
    this.xpReward,
    this.difficulty,
    this.status,
    this.thumbnailUrl,
    this.coachNote,
    this.estimatedCalories,
    this.drillsCount,
    this.sessionType,
    this.tags,
    this.drills,
  });

  factory TodaySession.fromJson(Map<String, dynamic> json) {
    return _$TodaySessionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TodaySessionToJson(this);
  }
}

@JsonSerializable()
class SummaryCards {
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "value")
  final String? value;
  @JsonKey(name: "subtitle")
  final String? subtitle;
  @JsonKey(name: "iconName")
  final String? iconName;
  @JsonKey(name: "color")
  final String? color;

  SummaryCards ({
    this.title,
    this.value,
    this.subtitle,
    this.iconName,
    this.color,
  });

  factory SummaryCards.fromJson(Map<String, dynamic> json) {
    return _$SummaryCardsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SummaryCardsToJson(this);
  }
}

@JsonSerializable()
class WeeklyActivity {
  @JsonKey(name: "dayName")
  final String? dayName;
  @JsonKey(name: "xpEarned")
  final int? xpEarned;

  WeeklyActivity ({
    this.dayName,
    this.xpEarned,
  });

  factory WeeklyActivity.fromJson(Map<String, dynamic> json) {
    return _$WeeklyActivityFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WeeklyActivityToJson(this);
  }
}

@JsonSerializable()
class QuickRecommendations {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "priority")
  final String? priority;
  @JsonKey(name: "linkedSessionId")
  final dynamic? linkedSessionId;
  @JsonKey(name: "linkedSessionTitle")
  final String? linkedSessionTitle;
  @JsonKey(name: "linkedLessonId")
  final String? linkedLessonId;
  @JsonKey(name: "iconName")
  final String? iconName;
  @JsonKey(name: "color")
  final String? color;
  @JsonKey(name: "xpBonus")
  final int? xpBonus;
  @JsonKey(name: "actionLabel")
  final String? actionLabel;

  QuickRecommendations ({
    this.id,
    this.title,
    this.description,
    this.type,
    this.priority,
    this.linkedSessionId,
    this.linkedSessionTitle,
    this.linkedLessonId,
    this.iconName,
    this.color,
    this.xpBonus,
    this.actionLabel,
  });

  factory QuickRecommendations.fromJson(Map<String, dynamic> json) {
    return _$QuickRecommendationsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuickRecommendationsToJson(this);
  }
}


