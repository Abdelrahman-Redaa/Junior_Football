// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_ai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisAiResponse _$AnalysisAiResponseFromJson(Map<String, dynamic> json) =>
    AnalysisAiResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnalysisAiResponseToJson(AnalysisAiResponse instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  skills: json['skills'] == null
      ? null
      : Skills.fromJson(json['skills'] as Map<String, dynamic>),
  advice: json['advice'] as String?,
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'skills': instance.skills,
  'advice': instance.advice,
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
