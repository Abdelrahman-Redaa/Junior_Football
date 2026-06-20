// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_weekly_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullWeeklyPlanResponse _$FullWeeklyPlanResponseFromJson(
  Map<String, dynamic> json,
) => FullWeeklyPlanResponse(
  dayName: json['dayName'] as String?,
  isToday: json['isToday'] as bool?,
  sessions: (json['sessions'] as List<dynamic>?)
      ?.map((e) => Sessions.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FullWeeklyPlanResponseToJson(
  FullWeeklyPlanResponse instance,
) => <String, dynamic>{
  'dayName': instance.dayName,
  'isToday': instance.isToday,
  'sessions': instance.sessions,
};

Sessions _$SessionsFromJson(Map<String, dynamic> json) => Sessions(
  id: json['id'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  expectedDurationMinutes: (json['expectedDurationMinutes'] as num?)?.toInt(),
  rewardXp: (json['rewardXp'] as num?)?.toInt(),
  thumbnailUrl: json['thumbnailUrl'] as String?,
  isCompleted: json['isCompleted'] as bool?,
  drills: (json['drills'] as List<dynamic>?)
      ?.map((e) => Drills.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SessionsToJson(Sessions instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'expectedDurationMinutes': instance.expectedDurationMinutes,
  'rewardXp': instance.rewardXp,
  'thumbnailUrl': instance.thumbnailUrl,
  'isCompleted': instance.isCompleted,
  'drills': instance.drills,
};

Drills _$DrillsFromJson(Map<String, dynamic> json) => Drills(
  id: json['id'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  repetitions: (json['repetitions'] as num?)?.toInt(),
  videoUrl: json['videoUrl'] as String?,
  orderIndex: (json['orderIndex'] as num?)?.toInt(),
);

Map<String, dynamic> _$DrillsToJson(Drills instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'repetitions': instance.repetitions,
  'videoUrl': instance.videoUrl,
  'orderIndex': instance.orderIndex,
};
