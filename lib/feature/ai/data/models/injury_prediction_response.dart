import 'package:json_annotation/json_annotation.dart';

part 'injury_prediction_response.g.dart';

@JsonSerializable()
class InjuryPredictionResponse {
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "advice")
  final String? advice;

  InjuryPredictionResponse ({
    this.title,
    this.advice,
  });

  factory InjuryPredictionResponse.fromJson(Map<String, dynamic> json) {
    return _$InjuryPredictionResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InjuryPredictionResponseToJson(this);
  }
}


