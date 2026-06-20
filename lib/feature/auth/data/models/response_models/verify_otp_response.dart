import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  @JsonKey(name: "isSuccess")
  final bool? isSuccess;
  @JsonKey(name: "message")
  final String? message;

  VerifyOtpResponse ({
    this.isSuccess,
    this.message,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return _$VerifyOtpResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerifyOtpResponseToJson(this);
  }
}


