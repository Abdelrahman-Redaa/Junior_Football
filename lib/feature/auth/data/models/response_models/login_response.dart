import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "isSuccess")
  final bool? isSuccess;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "refreshToken")
  final String? refreshToken;
  @JsonKey(name: "refreshTokenExpiration")
  final String? refreshTokenExpiration;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "fullName")
  final String? fullName;

  LoginResponse ({
    this.isSuccess,
    this.message,
    this.token,
    this.refreshToken,
    this.refreshTokenExpiration,
    this.email,
    this.fullName,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseToJson(this);
  }
}


