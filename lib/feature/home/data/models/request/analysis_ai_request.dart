import 'package:json_annotation/json_annotation.dart';

part 'analysis_ai_request.g.dart';

@JsonSerializable()
class AnalysisAiRequest {
  @JsonKey(name: "videoUrl")
  final String? videoUrl;
  @JsonKey(name: "drillType")
  final String? drillType;

  AnalysisAiRequest ({
    this.videoUrl,
    this.drillType,
  });

  factory AnalysisAiRequest.fromJson(Map<String, dynamic> json) {
    return _$AnalysisAiRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AnalysisAiRequestToJson(this);
  }
}


