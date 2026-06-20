import 'package:json_annotation/json_annotation.dart';

part 'verify-otp_request.g.dart';

@JsonSerializable()
class VerifyOtpRequest {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "otp")
  final String? otp;

  VerifyOtpRequest ({
    this.email,
    this.otp,
  });

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    return _$VerifyOtpRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerifyOtpRequestToJson(this);
  }
}


