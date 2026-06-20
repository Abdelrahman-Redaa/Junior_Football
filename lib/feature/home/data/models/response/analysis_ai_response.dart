import 'package:json_annotation/json_annotation.dart';

part 'analysis_ai_response.g.dart';

@JsonSerializable()
class AnalysisAiResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final Data? data;

  AnalysisAiResponse ({
    this.message,
    this.data,
  });

  factory AnalysisAiResponse.fromJson(Map<String, dynamic> json) {
    return _$AnalysisAiResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AnalysisAiResponseToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "skills")
  final Skills? skills;
  @JsonKey(name: "advice")
  final String? advice;

  Data ({
    this.skills,
    this.advice,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
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

  Skills ({
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


