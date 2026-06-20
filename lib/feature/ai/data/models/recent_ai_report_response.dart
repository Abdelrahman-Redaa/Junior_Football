import 'package:json_annotation/json_annotation.dart';

part 'recent_ai_report_response.g.dart';

@JsonSerializable()
class RecentAiReportResponse {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "drillType")
  final String? drillType;
  @JsonKey(name: "overallScore")
  final int? overallScore;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "recommendations")
  final List<String>? recommendations;
  @JsonKey(name: "skills")
  final Skills? skills;
  @JsonKey(name: "similarPlayerName")
  final String? similarPlayerName;
  @JsonKey(name: "similarPlayerClub")
  final String? similarPlayerClub;
  @JsonKey(name: "similarPlayerImageUrl")
  final String? similarPlayerImageUrl;

  RecentAiReportResponse({
    this.id,
    this.drillType,
    this.overallScore,
    this.createdAt,
    this.recommendations,
    this.skills,
    this.similarPlayerName,
    this.similarPlayerClub,
    this.similarPlayerImageUrl,
  });

  factory RecentAiReportResponse.fromJson(Map<String, dynamic> json) {
    return _$RecentAiReportResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RecentAiReportResponseToJson(this);
  }
}

@JsonSerializable()
class Skills {
  @JsonKey(name: "speed")
  final int? speed;
  @JsonKey(name: "shooting")
  final int? shooting;
  @JsonKey(name: "passing")
  final int? passing;
  @JsonKey(name: "positioning")
  final int? positioning;
  @JsonKey(name: "reaction")
  final int? reaction;

  Skills({
    this.speed,
    this.shooting,
    this.passing,
    this.positioning,
    this.reaction,
  });

  factory Skills.fromJson(Map<String, dynamic> json) {
    return _$SkillsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SkillsToJson(this);
  }
}
