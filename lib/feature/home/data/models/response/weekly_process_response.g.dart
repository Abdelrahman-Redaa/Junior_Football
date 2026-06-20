// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_process_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyProcessResponse _$WeeklyProcessResponseFromJson(
  Map<String, dynamic> json,
) => WeeklyProcessResponse(
  totalXp: (json['totalXp'] as num?)?.toInt(),
  totalSessionsCount: (json['totalSessionsCount'] as num?)?.toInt(),
  weeklyProgress: (json['weeklyProgress'] as List<dynamic>?)
      ?.map((e) => WeeklyProgress.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WeeklyProcessResponseToJson(
  WeeklyProcessResponse instance,
) => <String, dynamic>{
  'totalXp': instance.totalXp,
  'totalSessionsCount': instance.totalSessionsCount,
  'weeklyProgress': instance.weeklyProgress,
};

WeeklyProgress _$WeeklyProgressFromJson(Map<String, dynamic> json) =>
    WeeklyProgress(
      dayName: json['dayName'] as String?,
      xpEarned: (json['xpEarned'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WeeklyProgressToJson(WeeklyProgress instance) =>
    <String, dynamic>{
      'dayName': instance.dayName,
      'xpEarned': instance.xpEarned,
    };
