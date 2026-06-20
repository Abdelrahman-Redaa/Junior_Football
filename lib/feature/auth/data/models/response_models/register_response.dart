import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: "isSuccess")
  final bool? isSuccess;
  @JsonKey(name: "message")
  final String? message;

  RegisterResponse ({
    this.isSuccess,
    this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return _$RegisterResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterResponseToJson(this);
  }
}


