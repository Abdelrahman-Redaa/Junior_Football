// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_ai_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentAiReportResponse _$RecentAiReportResponseFromJson(
  Map<String, dynamic> json,
) => RecentAiReportResponse(
  id: json['id'] as String?,
  drillType: json['drillType'] as String?,
  overallScore: (json['overallScore'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
  recommendations: (json['recommendations'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  skills: json['skills'] == null
      ? null
      : Skills.fromJson(json['skills'] as Map<String, dynamic>),
  similarPlayerName: json['similarPlayerName'] as String?,
  similarPlayerClub: json['similarPlayerClub'] as String?,
  similarPlayerImageUrl: json['similarPlayerImageUrl'] as String?,
);

Map<String, dynamic> _$RecentAiReportResponseToJson(
  RecentAiReportResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'drillType': instance.drillType,
  'overallScore': instance.overallScore,
  'createdAt': instance.createdAt,
  'recommendations': instance.recommendations,
  'skills': instance.skills,
  'similarPlayerName': instance.similarPlayerName,
  'similarPlayerClub': instance.similarPlayerClub,
  'similarPlayerImageUrl': instance.similarPlayerImageUrl,
};

Skills _$SkillsFromJson(Map<String, dynamic> json) => Skills(
  speed: (json['speed'] as num?)?.toInt(),
  shooting: (json['shooting'] as num?)?.toInt(),
  passing: (json['passing'] as num?)?.toInt(),
  positioning: (json['positioning'] as num?)?.toInt(),
  reaction: (json['reaction'] as num?)?.toInt(),
);

Map<String, dynamic> _$SkillsToJson(Skills instance) => <String, dynamic>{
  'speed': instance.speed,
  'shooting': instance.shooting,
  'passing': instance.passing,
  'positioning': instance.positioning,
  'reaction': instance.reaction,
};
