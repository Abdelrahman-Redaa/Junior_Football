// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingDashboard _$TrainingDashboardFromJson(Map<String, dynamic> json) =>
    TrainingDashboard(
      userName: json['userName'] as String?,
      userLevel: json['userLevel'] as String?,
      userAvatarUrl: json['userAvatarUrl'] as String?,
      totalXp: (json['totalXp'] as num?)?.toInt(),
      nextLevelXp: (json['nextLevelXp'] as num?)?.toInt(),
      xpProgress: (json['xpProgress'] as num?)?.toInt(),
      weeklySessionsCompleted: (json['weeklySessionsCompleted'] as num?)
          ?.toInt(),
      weeklySessionsTotal: (json['weeklySessionsTotal'] as num?)?.toInt(),
      weeklyProgress: (json['weeklyProgress'] as num?)?.toInt(),
      totalCompletedSessions: (json['totalCompletedSessions'] as num?)?.toInt(),
      totalTrainingMinutes: (json['totalTrainingMinutes'] as num?)?.toInt(),
      currentStreak: (json['currentStreak'] as num?)?.toInt(),
      todaySession: json['todaySession'] == null
          ? null
          : TodaySession.fromJson(json['todaySession'] as Map<String, dynamic>),
      summaryCards: (json['summaryCards'] as List<dynamic>?)
          ?.map((e) => SummaryCards.fromJson(e as Map<String, dynamic>))
          .toList(),
      weeklyActivity: (json['weeklyActivity'] as List<dynamic>?)
          ?.map((e) => WeeklyActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentBadges: json['recentBadges'] as List<dynamic>?,
      quickRecommendations: (json['quickRecommendations'] as List<dynamic>?)
          ?.map((e) => QuickRecommendations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrainingDashboardToJson(TrainingDashboard instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'userLevel': instance.userLevel,
      'userAvatarUrl': instance.userAvatarUrl,
      'totalXp': instance.totalXp,
      'nextLevelXp': instance.nextLevelXp,
      'xpProgress': instance.xpProgress,
      'weeklySessionsCompleted': instance.weeklySessionsCompleted,
      'weeklySessionsTotal': instance.weeklySessionsTotal,
      'weeklyProgress': instance.weeklyProgress,
      'totalCompletedSessions': instance.totalCompletedSessions,
      'totalTrainingMinutes': instance.totalTrainingMinutes,
      'currentStreak': instance.currentStreak,
      'todaySession': instance.todaySession,
      'summaryCards': instance.summaryCards,
      'weeklyActivity': instance.weeklyActivity,
      'recentBadges': instance.recentBadges,
      'quickRecommendations': instance.quickRecommendations,
    };

TodaySession _$TodaySessionFromJson(Map<String, dynamic> json) => TodaySession(
  sessionId: json['sessionId'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
  xpReward: (json['xpReward'] as num?)?.toInt(),
  difficulty: json['difficulty'] as String?,
  status: json['status'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  coachNote: json['coachNote'] as String?,
  estimatedCalories: (json['estimatedCalories'] as num?)?.toInt(),
  drillsCount: (json['drillsCount'] as num?)?.toInt(),
  sessionType: json['sessionType'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  drills: json['drills'] as List<dynamic>?,
);

Map<String, dynamic> _$TodaySessionToJson(TodaySession instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'title': instance.title,
      'description': instance.description,
      'durationMinutes': instance.durationMinutes,
      'xpReward': instance.xpReward,
      'difficulty': instance.difficulty,
      'status': instance.status,
      'thumbnailUrl': instance.thumbnailUrl,
      'coachNote': instance.coachNote,
      'estimatedCalories': instance.estimatedCalories,
      'drillsCount': instance.drillsCount,
      'sessionType': instance.sessionType,
      'tags': instance.tags,
      'drills': instance.drills,
    };

SummaryCards _$SummaryCardsFromJson(Map<String, dynamic> json) => SummaryCards(
  title: json['title'] as String?,
  value: json['value'] as String?,
  subtitle: json['subtitle'] as String?,
  iconName: json['iconName'] as String?,
  color: json['color'] as String?,
);

Map<String, dynamic> _$SummaryCardsToJson(SummaryCards instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
      'subtitle': instance.subtitle,
      'iconName': instance.iconName,
      'color': instance.color,
    };

WeeklyActivity _$WeeklyActivityFromJson(Map<String, dynamic> json) =>
    WeeklyActivity(
      dayName: json['dayName'] as String?,
      xpEarned: (json['xpEarned'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WeeklyActivityToJson(WeeklyActivity instance) =>
    <String, dynamic>{
      'dayName': instance.dayName,
      'xpEarned': instance.xpEarned,
    };

QuickRecommendations _$QuickRecommendationsFromJson(
  Map<String, dynamic> json,
) => QuickRecommendations(
  id: json['id'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  type: json['type'] as String?,
  priority: json['priority'] as String?,
  linkedSessionId: json['linkedSessionId'],
  linkedSessionTitle: json['linkedSessionTitle'] as String?,
  linkedLessonId: json['linkedLessonId'] as String?,
  iconName: json['iconName'] as String?,
  color: json['color'] as String?,
  xpBonus: (json['xpBonus'] as num?)?.toInt(),
  actionLabel: json['actionLabel'] as String?,
);

Map<String, dynamic> _$QuickRecommendationsToJson(
  QuickRecommendations instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'priority': instance.priority,
  'linkedSessionId': instance.linkedSessionId,
  'linkedSessionTitle': instance.linkedSessionTitle,
  'linkedLessonId': instance.linkedLessonId,
  'iconName': instance.iconName,
  'color': instance.color,
  'xpBonus': instance.xpBonus,
  'actionLabel': instance.actionLabel,
};
