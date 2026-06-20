import 'package:json_annotation/json_annotation.dart';

part 'created_response.g.dart';

@JsonSerializable()
class CreatedResponse {
  @JsonKey(name: "isSuccess")
  final bool? isSuccess;
  @JsonKey(name: "message")
  final String? message;

  CreatedResponse ({
    this.isSuccess,
    this.message,
  });

  factory CreatedResponse.fromJson(Map<String, dynamic> json) {
    return _$CreatedResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreatedResponseToJson(this);
  }
}


