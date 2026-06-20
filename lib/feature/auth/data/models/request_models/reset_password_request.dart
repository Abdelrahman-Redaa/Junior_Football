import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class RestPasswordRequest {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "newPassword")
  final String? newPassword;

  RestPasswordRequest ({
    this.email,
    this.newPassword,
  });

  factory RestPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$RestPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RestPasswordRequestToJson(this);
  }
}


